Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438E3CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYJW-00070r-3N; Wed, 22 Oct 2025 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBYJT-00070B-Ac
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBYJR-0002KQ-Lr
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761137492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+89XovxeYcmyRTLVJKC98GGAfpoun4TAOLu7yQDres=;
 b=YcAa+01IDAtR8m/jILkIIcIFg7Lv9uGW/jvXakRlQFS26D963SatsnNjYpW2k9PRXedWhQ
 Rc3CoowewMYDWPIlE1/yKDICsvPwsDTKLVCWx+kOfmZ15GjIRtbZrAlLQ5olrObmVHuBUb
 xGaj/gV85T54O3fJobRa7fcJgTZ6/CU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-oWTqkeVlOMS5U8vJuA6alA-1; Wed, 22 Oct 2025 08:51:29 -0400
X-MC-Unique: oWTqkeVlOMS5U8vJuA6alA-1
X-Mimecast-MFC-AGG-ID: oWTqkeVlOMS5U8vJuA6alA_1761137487
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8906059f6b2so4012937085a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761137487; x=1761742287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+89XovxeYcmyRTLVJKC98GGAfpoun4TAOLu7yQDres=;
 b=StLRSUzywTp4py1CTvPuj+dN7NWs/zX8y4WCM7sY8/C9GZ90oYCwKSTh1VcgroSqOL
 7uMZoInW/ooYITvd2y9NKAxaQ0oiwSHmhyH5Rhb4W9DyvkismnV6OmLZeCMcW0n+HGmZ
 gwX3ozAMZO3Jaex5JYb0Fx9ShUlPHUlDATHsrkre8SIwrPJVmm22wTRI+1Lgclv7bnEO
 ndzrwnmJCftNaR5BxVT3EGzBBZbKxV3Rdg/FHYHq5UTqQvVVpy9UtczPWEk4HszAghhU
 Q3K120qMtuU+RFgn3kVnPYB3fhGMoZzYDmf7Ch3U5wzY5sjRc1k20J1x32606LWMSypW
 aOow==
X-Gm-Message-State: AOJu0YwEppi8DaSIZPGjRgEcUJ0oJ3D3dGbCPiEDshUr6cPvE9422xEu
 PgCk3/hsUrJSFfUxWpBQV2UXY+fI9q8P1sC48FCumZVGJfB22yptY1ZwX4tx3ZcX+cv54nc7KdZ
 cgxk3Mjwdcn0rnpn/iS49GCkaHvXIKTJ/mtSeUQr0tR/kZxpkPdC2H3sB
X-Gm-Gg: ASbGncv3chZMUMDmItVJcLdmFgASvV5VycX6Q3wxqK1j4eVkkcd4YTc6HcAaB6WXXlc
 qM8TlP2+PuwsBiUv5IgjhB2v53hn/jQK1VNF4I1Zin9QS8BStEGVOgde8LmRI/7l2YwiwAh9yzU
 eyy2Q/JKgqmgxhp1ojSXPfqh2EO73dNSDFGZ8gjmXCyItOhUp0kkTBI5ALCEHQNUNf423Fn5kaN
 IuJYfoheYx27wYVqYKAMn7TWaxBPCPgR8IKuBdaWa62q9Nkk2dYX9TcOciE/YAn6YZBtIgXJ70b
 AU22v7G2joESbUSaou6gXZPqwFeN5FmcjG1SGXRpk0Xm8DZvZ5CbcPgwFBfGxz01maY=
X-Received: by 2002:a05:620a:4442:b0:800:367d:b9cf with SMTP id
 af79cd13be357-8906ec8cab2mr2447117085a.38.1761137487501; 
 Wed, 22 Oct 2025 05:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkLcox/zM3s3aQGti/8SJMI4ek4qxHUL2Qx5SEIL+ateo/3JrYZTbhiw2VvzyAqpBTIb/2fw==
X-Received: by 2002:a05:620a:4442:b0:800:367d:b9cf with SMTP id
 af79cd13be357-8906ec8cab2mr2447111585a.38.1761137486898; 
 Wed, 22 Oct 2025 05:51:26 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf590691sm963437685a.52.2025.10.22.05.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:51:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:51:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Arun Menon <armenon@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
Message-ID: <aPjTSkQHHCdSdiFv@x1.local>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-3-peterx@redhat.com>
 <87o6q0t1z0.fsf@suse.de> <aPf7R-F0uv1RSqXh@x1.local>
 <87frbbt98m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frbbt98m.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 22, 2025 at 09:24:25AM -0300, Fabiano Rosas wrote:
> Remember to copy Oracle folks.

Do you know who's taking this over from Steve?  If we know, we should
update the MAINTAINERS file.

-- 
Peter Xu


