Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D867CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5Fh-00062Y-BG; Wed, 29 Apr 2026 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI5Fd-000629-Rx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI5Fb-0002sx-Uy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777470410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xfaOPt1xb4oDomIGx6Rbcw1ZLAPhhhrwgxi/BMZujIc=;
 b=FTHIV7IVFbGQo+aJD4IzUmK7Ut1f0Clouy5sOfhz1UvjePl18YNg//0adXK1isviWJCHkx
 MlQ6lNtRfBXGUdumj/IFlxY8yrmwGjP66p743i5ZM0uBLZ+g1cZVewfnw3sYXUqc4324Eq
 yfqyNsesRe1DwshHbslvTxRowMCHHTk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-RxkAcOmiO0OJ2sq2L-kHdw-1; Wed, 29 Apr 2026 09:46:48 -0400
X-MC-Unique: RxkAcOmiO0OJ2sq2L-kHdw-1
X-Mimecast-MFC-AGG-ID: RxkAcOmiO0OJ2sq2L-kHdw_1777470408
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eaec5f60edso123110085a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777470408; x=1778075208; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfaOPt1xb4oDomIGx6Rbcw1ZLAPhhhrwgxi/BMZujIc=;
 b=jkJVkQh1TI8rQ1mOuDDeDDKez5Y1HdU9wfZ71Mh3dffhaZ7JKqNXEww9fGGbZGti/F
 iNXzgYVfa7Aj5D5ibBHET53lerHFZkWUsNQxGBJbJgUGOlcQx+MXp4J3u2BYtsV5PFsM
 gyGNs6QxmpIrhBvPpuCkqlm84iUSnaVZxMajV8/jI63+ja6sxYXBZmpMMhWo3EyzcGaC
 l63OhDhVTg238TSt5E7PIO2L2tXNqtXTtMd7mQWhwGebhq4cYxCfaYmCRks2/HHcz+js
 rtrW5mwfD/8MUBnEecX6VRb7QhdTpodgrSjcVZFOlPU/h4hdzKfRv3O94X4lOS81sGLj
 E1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777470408; x=1778075208;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfaOPt1xb4oDomIGx6Rbcw1ZLAPhhhrwgxi/BMZujIc=;
 b=g/A3Los7VKUHIkBuj1Q264ayL/Uhu0hPmqub5Tao4YTWIVaFlYNPUit/MkAfXotQsI
 lxQtVUii1xPOlckemyAa1nOTIsWhNMI9T4+qBWI1xqHW/2Kkhk/Eia8AiZPO//myUzlo
 MVLycuFewxeY0Fx2xuZ/biiWq2nmGQBYQT8v3bbK9klR50tlfgUBOvGa2j1zlMpviv/S
 iiZYk2QOQii6KfIHbZsxQ+IA3WkRE+klqRIxP5PyuXxCknZ4v+d+l3rtF4oAmd6mp/qF
 fZoRjgZd3ml894IKqN4bUFr6M2wVW9TU/FiUH/xqLCGd2nGe0NMmshlXJYOJtEAdB72C
 Lkhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8REK4AsgFZi+JpitK/YFz5JfbTQWr7jFvxXNC+/XWXCf2AocbZtqKNp9/a5vyMQ4oe3OUy/IhqHRc@nongnu.org
X-Gm-Message-State: AOJu0YwNoHk1Z5pT42BldOveGBWvTwDEDpzNQRO5n0GqximjSgCHOLlt
 IYo2GTTmOSsnGeBj1l8RttDMtT5rdMQ73DxO+DssnKnuQXYM+bmim4E20O84aGF3brUSrwLOSlP
 RqcaBtpvvM4Ps3yo1zwpY2qR/RaGmWFK8HStOKOjQ8fsiy/ciO54vwdv/
X-Gm-Gg: AeBDiet1+Aw6bL2ghaxc6L+W8bu9XptKhI/ZJKUbnhwDp3Y3Xhb+kUvMhLnuxADVLSO
 MtG+IZG1BhnBcwhASoXwKfCVzb+iymQdHcoq/R768gAfhQmbf6NEV2yjfHBi23i3gkP7bGTXk7N
 lyqBXXPSxAk4WZzwSQT5YaM1Zn9Xb9YxWCRbBb0fMgPymfnX+dDnVbI6y1+L6KD+08qTJr0MAZm
 TxIXHj3r9ygLKuR7BfuPMhWZ/pk1lUEwPhMEFp+gxoPMXNtWkv3qdhOgIF71TxU4JNmZ1/Kxffn
 NcCcht5fNw2WgiORJJf2HmTb7mg7r1Mz46d/hrHziRs4K5XDVVEQVnbR4+gnQA1u4X0wMIhLhuC
 8eU2b0VqyqAxxTb0YqerfzRC2XRCOStY=
X-Received: by 2002:a05:620a:400d:b0:8ee:f390:8f85 with SMTP id
 af79cd13be357-8f7d6f3d794mr1005900385a.3.1777470407464; 
 Wed, 29 Apr 2026 06:46:47 -0700 (PDT)
X-Received: by 2002:a05:620a:400d:b0:8ee:f390:8f85 with SMTP id
 af79cd13be357-8f7d6f3d794mr1005895185a.3.1777470406935; 
 Wed, 29 Apr 2026 06:46:46 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f940149894sm193098085a.42.2026.04.29.06.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:46:46 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:46:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, philmd@linaro.org,
 peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Message-ID: <afILw6Pq5QZ0ONKr@redhat.com>
References: <69ef8131.050a0220.11648d.40e6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69ef8131.050a0220.11648d.40e6@mx.google.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 06:30:56PM +0300, elisey.konstantinov wrote:
> Yeah, this sounds weird, could you please test on the old distribution,
> like Debian 12?See three of my latest messages in the main thread for
> more information

Note, as upstream maintainers we don't generally have the resources to
troubleshoot older distribution packages. If something only reproduces
on distro packages, not QEMU git master, then it needs to be reported
to the relevant OS distro bug tracker and the downsteam maintainer(s)
need to take responsibility for it.


With regards,
Daniel


