Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE8ECD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtk7-0003i0-7L; Fri, 15 May 2026 10:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNtk5-0003hn-Mi
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNtk1-0006Vm-KK
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778856136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kw134qv454wYj1vXFo830vSIdJ7nkK9og9zvffIwLGE=;
 b=H5W9pzGIrYJYMiurgQAqTC1EW3LpV721Hcf+lUfyFtjIHYu6/C09H6boa99Yiu/T7kdxJt
 Z5oC4/5vcKUxyKJfd48aQ7Im432LZ1nYCmwot2mr66tpCdwjE7iqSBpQqRdgIwPYGTtmL+
 Uf6aImjtTi+6kee0x9dnB4Rc0gfCRZU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507--0dQAygIMO6AIoPBMadbPQ-1; Fri, 15 May 2026 10:42:14 -0400
X-MC-Unique: -0dQAygIMO6AIoPBMadbPQ-1
X-Mimecast-MFC-AGG-ID: -0dQAygIMO6AIoPBMadbPQ_1778856133
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-393d72477bfso44562431fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778856133; x=1779460933; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kw134qv454wYj1vXFo830vSIdJ7nkK9og9zvffIwLGE=;
 b=XLOMEds2dtacTAnjiEv0y3T7O6r6kPpn6JVWAQIdv+PnJyAwdt1IbEI1cq1c+0bzIK
 LjG4RWXY+p9yo0EX/JbW5+ASrbNpfRGR6XIviAf62P5qgMZsUFCIhVLEue/LqqamL00a
 Py/XKYsSr+qzXKtTBf9etzfe/D/RbmdYdDetTo7FjN56kSzG6EDmFt4Vzx8AmkDAeWjZ
 +z3xgu/LaUrIkx2/OtPhxSfCKbn7nPcoQ/8YShCTjrNjd0CLzujlxFcRaA00bt/ZO/xp
 U/x1KE4+fEmGK4/S0+EVSOeuo0vvpqis7iGhpEYnjmxlfhJsWFKGcq1qYcUjNxclFXUF
 JsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778856133; x=1779460933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kw134qv454wYj1vXFo830vSIdJ7nkK9og9zvffIwLGE=;
 b=jWFwlW+ljPHKw6YHnrhAAWnR49yb41ggJm5e7rN87Fklvqc9i51TPhDIMiCp5uzyC8
 tWV3F0PaMmw9uc1WL43qI3StAhYkasvIcXenu1lhJlmdyN4nPY6v1GYiXFY34ZglnqeI
 G/9//+M3UIY/Ay1DPQoJEsx7IKv11LVcufeDZyouc5JHpKlLwIhSZ9FKwi6Ch3L1F6lB
 jnhmWviPS5QetHd4PLK5hOFq0X71y2YNnxZoH/OZsxmWEgXaNYeS7zSVOymvaaM+7+gs
 f3xIa+JEaPbtjSvaeFg4rxQHwOURmKzui5pqnNkEaFz4wHtG2Kld670rd8L6nxc3sxff
 EZaw==
X-Gm-Message-State: AOJu0YxX1HPfmYcNEaWhH087WpOjNTJ0y6e9l7snMDbVAs8EnU5OsLBC
 QxlvvgVecXoSVoGj5VKjbdEzrkZh0A/Hzr/QuiJ/TZsPFHtYcUIteMykWJMsxymvXOowe4k+Gm9
 lr2g0/nxOSxGo1lkPMhSLLO6+lrY/u+KuLiQxJNcb/G7U0ByXTEDzPPN8
X-Gm-Gg: Acq92OHAXMiQKlOVdio4adcAVis/ZirZQWTeck5H7UZo0CQfOUsQXrMZngpi960bpDI
 o4rJThf/K/LCVeNzdMWQHBWJRDX/c8PEZEzB6W+p977BPZbR7zOyHxMWByCBelvt+fqpBY81rHx
 xgQFaB2cCr1VM4Bj2v5/GbaQKUPBUlvIe6mjAZuI9Wz72/jvs/jiZyrqIAH8v/E3xiSYGakcWUA
 Qu8jZwv0h65+NOUY5Fjp8XoZgAzxaStotOv1HOPrpGvj1uO6khDOGbVlVKBfn4vAdxIFTXCRMYu
 WB5cgIFp3ZxcFti3EQR9ViZZ2z5BU8UJgzTXB/RE8vBMY+o/6jxcZauPaLnwTzAjIBL4hrEvhFO
 Nb0yvsKu5h7HMvAWqzvemziFjMwVx/9Zga30VtBsu01oYShs=
X-Received: by 2002:a05:651c:1141:b0:38e:2fcc:78fe with SMTP id
 38308e7fff4ca-39561c05430mr13570721fa.3.1778856132889; 
 Fri, 15 May 2026 07:42:12 -0700 (PDT)
X-Received: by 2002:a05:651c:1141:b0:38e:2fcc:78fe with SMTP id
 38308e7fff4ca-39561c05430mr13570601fa.3.1778856132217; 
 Fri, 15 May 2026 07:42:12 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945cb015f9sm15690801fa.32.2026.05.15.07.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:42:11 -0700 (PDT)
Date: Fri, 15 May 2026 10:42:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: use eventfd functions instead of bare
 read/write
Message-ID: <agcwwAdQ7_F865PR@x1.local>
References: <20260514075136.301706-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514075136.301706-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 14, 2026 at 01:21:37PM +0530, Aadeshveer Singh wrote:
> Replace read() and write() syscalls on eventfd with glibc wrappers
> eventfd_read() and eventfd_write(), to make code more robust, readable
> and future-proof.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

queued, thanks

-- 
Peter Xu


