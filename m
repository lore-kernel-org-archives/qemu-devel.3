Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC5AF01825
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyT9L-0002MD-Si; Fri, 06 Mar 2026 06:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyT9J-0002Kl-QA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyT9I-0006xg-3Y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772795713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZhNksprdYhJsFBJGHpehsA641Ev1DzrhMR/qi8A+aY=;
 b=QWxnBMcqne8GLNR9MROCLJNmfe0SeOYZgJAalu8GDrPU2CG+jOoSh/Hr4EZzAgp/4/c2bO
 e0bvtXyCYCJrUSvK4XkfmYIftWb3rrk10J8+rCF4W4fkbwbDLRE1NobgZUfDIAK7Hvdio9
 viAgiGMjZBQj22uzEemtAE1GZqRQ/Lk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-3b4miCXnN_uD2RDzB0f9cg-1; Fri, 06 Mar 2026 06:15:12 -0500
X-MC-Unique: 3b4miCXnN_uD2RDzB0f9cg-1
X-Mimecast-MFC-AGG-ID: 3b4miCXnN_uD2RDzB0f9cg_1772795711
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439c112b1a4so2951432f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772795711; x=1773400511; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=EZhNksprdYhJsFBJGHpehsA641Ev1DzrhMR/qi8A+aY=;
 b=DCBGmhdkkSrvH299m/u/Lc4abK3hFSZrIKHLZpqk+sfXQSvDIiMBiQgbNXbiXRAM7j
 S4BuD8B4+HgKAeIPPHAT12WuHAbLL4+pneH3e8UxYzy1zsyJ4zUu4aHrvsFcsK7sQCQB
 HW7CxRf+WU0G8gh8RVYUFlw+OiHluq2fJZCTZp3Xtki9DthUxYfPhXo094B7/h1Mzd0W
 Cv8kHwZqdxY8/5doDRC2dNnGkffvGvlNrJJF+egR2QgPsOYKhA/OKj12zB6abz+jL6g6
 xinpGc7IWA24g+hStRHHtRoIIBv7pfWGIIVXHkUmxY9m6Q8iXDTSl9OxaqU6F1F2dfnZ
 Gesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772795711; x=1773400511;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZhNksprdYhJsFBJGHpehsA641Ev1DzrhMR/qi8A+aY=;
 b=O7uV2zYD+UMy1/DV02AFzrCVT2NTN1A7GyHYckPSYiiP/Lfk4WsFWPjdbXsW1W6rEk
 VLEBtKnt1lE1ecigaCCDV2UPUMHhA67fWPKh5kKZdgX1V/rrO7boWQmCaWzqbt6thOvV
 PwE2eVrwuw0cbDjKb+9KlrEiuGMX3IgHEYsgt5h8740fGfP7+aBFSnNmJUPRfkb3JUAI
 1XL57/QPq3o18CLLUrZsMpa814YSVUFUuSoXCUF6dlDpl4oVhGosxnJERicoPbtARs/Z
 Hy6NKb6yhQKUs+mIpZwxFpPtBRE7+FlFJ7Adzmw0Zet28pIoN+K9IDm6rppHii4SA3Ye
 Pk0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlb3om6v90bXYICXDpoDqPL4ov6n4joJwnntbUtW14ce2FuYih9P0+fVIJCWi/lan1xP2RhAiDvfzd@nongnu.org
X-Gm-Message-State: AOJu0YwV+f6LYsYiAjabzlbcE+MHRec+5vmxDpj/NrsNk5tiN9LD4BS7
 BGa2ek9/FvawwTH/UK+h5sBQEXtafdJjMIbZ5k7xmAw4e0d6Edkwt+27MHnU/Q88etd4sJRmLf0
 9LhoTv0QQZzI+3rZVVCmYrs0TrCqmmg+lJqoYYJS3bNH7su3eYj+A9vA5
X-Gm-Gg: ATEYQzzSeZN3R9w4Sk0hYhHEM/nJ565tibhfZ605CBt7AdFlKORLkTPVlJxL+nH4j/b
 M+4D2U4nJTOGD5FooGK1HYaXJql7EK6oNIuqOgpeifT7Bj6PF48/TGRufGc0Jik0P5t+qqEPIEE
 IiV+aMIFwdzhq8/B0xLgIQaeVzI62PrdjSWgDYvPXFNvD4SgyfUWqUfr+ryXEMvSsQqactbkutw
 4ugiqY3tCvzwD7fF0cLSjKe5C8Q374L3HtkqYAPMwdwiohKC+dUNF94zxbeYI/YTdc/X++sgYlp
 bMALdKZvdHvBElnQ5zTUjr62K+zwow5D6QetKsc+gdnoZJui9ky74gA1hPsD2broW9lOIjQhtDi
 dAOrr9pvojf9ynGCjp+mloXyO/4IUFOB7IWorqh82wbUSHpeosPyzhRHiZEJwe5bkw50s
X-Received: by 2002:a5d:64c9:0:b0:439:cee7:714f with SMTP id
 ffacd0b85a97d-439da86f5afmr2779353f8f.53.1772795711110; 
 Fri, 06 Mar 2026 03:15:11 -0800 (PST)
X-Received: by 2002:a5d:64c9:0:b0:439:cee7:714f with SMTP id
 ffacd0b85a97d-439da86f5afmr2779286f8f.53.1772795710612; 
 Fri, 06 Mar 2026 03:15:10 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae483desm2884818f8f.34.2026.03.06.03.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 03:15:10 -0800 (PST)
Date: Fri, 6 Mar 2026 12:15:09 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 5/6] target/arm/helper: Define cpreg migration tolerance
 for DGBDTR_EL0
In-Reply-To: <20260304102249.1963784-6-eric.auger@redhat.com>
Message-ID: <ec81a766-8a0c-48e1-be74-fdd4cdf90f66@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-6-eric.auger@redhat.com>
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
> We want to remove AArch32 DBGDTRTX which was erroneously exposed.
> This was attempted by 655659a74a36b ("target/arm: Correct encoding
> of Debug Communications Channel registers") but it was discovered
> that the removal of this debug register broke forward migration on
> TCG. Now we have the cpreg migration tolerance infrastructure, we
> can declare one for the DBGDTRTX. This allow to revert the reinstate
> patch.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


