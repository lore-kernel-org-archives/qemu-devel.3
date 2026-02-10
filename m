Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6D1EB26E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpr98-0005OC-MD; Tue, 10 Feb 2026 12:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpr74-0004sf-5r
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpr70-0006X6-60
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770742875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5q311A4DLq/hHpVhbJVn/VbIWwwO616F9+BUhUdAMz4=;
 b=Du88tl2TkoVVqHpomsDyCL7p4fCQnVyBgj9OemCpMzxngMtR52/DJNTcS0khqkrG55SvPQ
 QPLyivnCP+AZw2MW5T2qo/mevOd28ruj41nWEPW7sO01btsHDtrbyp/1sGCytni5kZLEUl
 EOzwYRtMBOUOQdDhf5AimRGVehIjQ1c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-KP0d0_NvPa27ujTReokz7Q-1; Tue, 10 Feb 2026 12:01:10 -0500
X-MC-Unique: KP0d0_NvPa27ujTReokz7Q-1
X-Mimecast-MFC-AGG-ID: KP0d0_NvPa27ujTReokz7Q_1770742869
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c881d0c617so1223538885a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770742869; x=1771347669; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5q311A4DLq/hHpVhbJVn/VbIWwwO616F9+BUhUdAMz4=;
 b=lJQAp5dcXynvK3bQzZE84mEVrEQfYYpdfM0Yrn21EfSQwTjCC7vzrwFuW+cqdhP3y3
 w4klRPxyobDjMgMYfW/paohg7RVgdSzmXedb95Z3WGtuprqIrLrBwlI1Dej7nQMEbNGM
 1Me+uxy1WCYv/rmU5+rvdd9hLebv9NTAtF5A/3Ee8COfc9y/8ojGAvLn4BMRfeIPbNic
 PW16uHNnhOUlTr/isuuW8xHcMglHgrsTEP7xbCA4ol4wSuBb5BDjPEPdtWu/HRxgKo5s
 DQ+o8cDPV/xWFrudWTHUEw+F+VlJ+Tt72vkVHGvBFIZcLBBBGdPKTV8spnAyyeaI/lTi
 +ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770742869; x=1771347669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5q311A4DLq/hHpVhbJVn/VbIWwwO616F9+BUhUdAMz4=;
 b=Exlm6LPdk3pOLZOt+/sGOV1yHaxWqX3u+DzR7qIvV8fVAnvPX2OpE/efRbg0yb/H62
 XLizAxo1CA/Nu0lmjN2g166sZ3A4brSJmyCknJKWPs1qymP85WdZdqGBk+X7oPb3WoJf
 p0EcS9LK2e7jx9PmC4sV/75HMhlNdm8tj1b0Zo4Mq55n7pyFyxGgb/tRBbJ1npqL+W4V
 f1VKQYxW+31HSfuKd2ON02qrWDb0MBDDJBrJVKNcswkiGLuPKxWfi6QhFx8oEAQDK1jt
 MbjCW/lJgYQkWtzRPbbFX+va4vwy4iqFZzbqn5GmnBUltIyWvKpMkrBdarrlWKBFe8KZ
 fw6Q==
X-Gm-Message-State: AOJu0Yxqup5FtxSoU/gjN42uTYTdV20TO3d4GE3gbY3Z3m1KrZRQcjoX
 xR5rPySuFxP/nrXau6wgzKlF5IfFU89NZAjDdxTm7Bula8kF8aObNEJB2kQgawrW4XswugOsvZo
 YAYhVb0NF8A//zoWrAim1AuoczFjMNBhC3ZkkOBcgtn70dEPw494q1Gr4
X-Gm-Gg: AZuq6aKw8Ma39IRVL4sOSAdKRzBjQRiwCENQQYzG0fqW1RzXAqFp8YJI5a1ArGvo4da
 tfM1MZAW9MGfki9SvNt5dqh0z8By4u+/eH8qR9jriCRqeWMKgoqezBGxQ2qzOaMkrC0q61Sx2NN
 NIA2Lc1ufh81V52+PHE1obMR3R9VYNtluqQX8OIQCh4IBlJmy8/9H4gMgYXeZmgebMRYFGcNBkx
 HcFOE5g5ITRVlk0hYXS5va0ajWRFBpq3jHd/zTA75Xo17CSMBWPldTuYuuLJ35ibLZx59qaqqqZ
 UCE5MelVtIrtsZhlhOdqURxpv2Ch7HDiTWZ7qTE1ed0ArHqR98fuGKg4LlPI/JksnBDPyIok5X5
 te9dlcfgSeLL2lw==
X-Received: by 2002:a05:620a:2954:b0:8c9:f4ed:c383 with SMTP id
 af79cd13be357-8caef408eeamr1975340985a.33.1770742859063; 
 Tue, 10 Feb 2026 09:00:59 -0800 (PST)
X-Received: by 2002:a05:620a:2954:b0:8c9:f4ed:c383 with SMTP id
 af79cd13be357-8caef408eeamr1975186385a.33.1770742849404; 
 Tue, 10 Feb 2026 09:00:49 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf982b851sm1118292085a.33.2026.02.10.09.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 09:00:48 -0800 (PST)
Date: Tue, 10 Feb 2026 12:00:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v8 05/17] colo: Remove ENABLE_COLO savevm command and
 mark it as deprecated
Message-ID: <aYtkNGvsimVxCwZf@x1.local>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
 <20260210-colo_unit_test_multifd-v8-5-7f9e5f7d082b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210-colo_unit_test_multifd-v8-5-7f9e5f7d082b@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 10, 2026 at 05:23:03PM +0100, Lukas Straub wrote:
> No need for it anymore now that x-colo capability is required
> on incoming side. There is also no need to send it for backwards
> compatibility since we only support COLO with the same version on
> both sides.
> 
> We mark the command code as deprecated and now error out if such
> a unhandled command is encountered in loadvm_process_command().
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Thanks,

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


