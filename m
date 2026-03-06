Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787A2F01826
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyT9z-0002xz-O3; Fri, 06 Mar 2026 06:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyT9w-0002uu-VY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyT9v-000705-Hd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772795754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qo3kIthpbu86oqvhJHhcBYejXdkDE3R4zfUK2Kn/520=;
 b=Zg4Pr/Hn7tAhZT0+iB9II/ZbKS3mjYhaTQG0tgWVOL1pw7i9fOne99xeUQitw9bdqTjy3s
 6hx+bXZxYt3lm4nHJ43XoiBfO9qrEO1t8J3flHg8cJUJrt4Y4R7EhdT2lNld4N5OzsDeiS
 RiEQRL3Je7WFDfwNVStzqs++U6X0HUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-7ApibkUuOSWWdUY9cJiWxA-1; Fri, 06 Mar 2026 06:15:53 -0500
X-MC-Unique: 7ApibkUuOSWWdUY9cJiWxA-1
X-Mimecast-MFC-AGG-ID: 7ApibkUuOSWWdUY9cJiWxA_1772795752
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so47621535e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772795752; x=1773400552; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qo3kIthpbu86oqvhJHhcBYejXdkDE3R4zfUK2Kn/520=;
 b=RPDLljDndKFm3HF0dduHW8Zy+GDQ26gPd1NCIVxn2b3smaQr36hZfZvBLA/B1fc+Nm
 9s4zlUAhDZURzxvqra/M3m0JeHVUBBKIPIgw3tW/vtO0dZlrGI8beyOADw+xiGzg2ahH
 HxO1kJT4CC7fjimM8iTc7p3u3rvT2+OZoE/BijiB+50kvRdGiBAK4HvFfDw24AHA31YZ
 12HnuGEzo4ymBAycFpNPoWmSes2Yaqp//4aOu7fY/wZWgND57piyqRukJjkrZ0M98lZX
 e2ZUnhVu1YodSw+AJgsB5D+lxzzBCyiVnQt79UWLf0aJVwMjER5B9TR9XGi8lwtYmY1a
 OThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772795752; x=1773400552;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qo3kIthpbu86oqvhJHhcBYejXdkDE3R4zfUK2Kn/520=;
 b=O7kQnIK0sQsI2lpYxu686N3Z9Xw5By28tXd2JOA/1R3odQ9zh5b5jSbqd0fEly4h05
 EB5GZMyJMUif/zDSiZ6Ez4ln91WldreDNXcRtMplW5Rhruijtdk5SSHHJJzXP56n7Zmn
 Kc2yb6+AbSw3/vnW00LDw8TuIEb4rimdOv5xOAFJpdfdhNRyOzzlYuz3q/mHQ1LJulFR
 4Ps5UJ6SQLEM1Z9Pa5tRTtATd8pEbptolKwdrjHNAH8bAPuR8/8/tEv/gf26TTLelwHr
 qjUuuEabQihMEz5IGt6AgXRdn1Kia7rLqSkIvdVNmpP8+LYVyEzLK8/AejDPsOO0dz9u
 yvTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRX76T338DtSGG1K49yAPx9vaCZXjFWA56a6U4Uo4NUgL4/8YjBxq20u774U5QRndpupNkcI3ulg/k@nongnu.org
X-Gm-Message-State: AOJu0YzMeSs34fgPAxHWn1bTDS/JtFVeVljOxaSu4vaFizUynTOSi66I
 ZHBfU3t8k92Ohbeu3B1x83c8IwaGTRhiDaaw1XBiobIFwtaye6RKfu39bsRvuLq1zhhmtROHp37
 sbHWwZygbXrWzCo171Zdg0xFeGlplgHYg0VJFNxZOAgi7CwBR0e5zta7U
X-Gm-Gg: ATEYQzxPVDCG4OImYFZ0Dn9anfE3fKTq1olXcI33+12jCaWXtkvZ3vw+LpqRlKw86d8
 ligCAqT20GS50p674B47PXnJ9oksHl9mFmKwfy1U1X0no6Ih0E6QVOKQ8GAG090+OAPMEBHlio2
 faTK/mZb4oXaeKGUvuGf2vQJAmHOJ8OcDmwxFFT8vVSvSrsomxNswgsKGQ592HMlAy6vyHfB2un
 Fmk7ed4A3K6vcxzwi2pGhMuDtraiEHEyY9A9ARuH+I6VnsiYQLGHCumz+y27qHM96tD2FVev9/q
 9bI9UDkPTC22U2H8NkDyrCmY5/9qeuPNxvTJ3d/cBzmkTsIDcyElNG+HoRKfv8yjYODXwEBte9D
 YiCaOefPCWIl8dpyhjnYEtT9fUFpLXiR7KZ/IBS0M+sgHHHx09hpLwnSlE53+Zpi/71/b
X-Received: by 2002:a05:600c:3488:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-48526923bc7mr26113415e9.9.1772795752214; 
 Fri, 06 Mar 2026 03:15:52 -0800 (PST)
X-Received: by 2002:a05:600c:3488:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-48526923bc7mr26112845e9.9.1772795751835; 
 Fri, 06 Mar 2026 03:15:51 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b0adasm27151425e9.10.2026.03.06.03.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 03:15:51 -0800 (PST)
Date: Fri, 6 Mar 2026 12:15:50 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 6/6] Revert "target/arm: Reinstate bogus AArch32
 DBGDTRTX register for migration compat"
In-Reply-To: <20260304102249.1963784-7-eric.auger@redhat.com>
Message-ID: <4c2ed24a-039f-4312-0512-209f446deead@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 4 Mar 2026, Eric Auger wrote:
> This reverts commit 4f2b82f60431 ("target/arm: Reinstate bogus AArch32
> DBGDTRTX register for migration compat). We don't need that commit
> anymore as the AArch32 DBGDTRTX register is declared to
> be safe to ignore in the incoming migration stream.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


