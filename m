Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918FDEE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKpl-000091-69; Fri, 06 Feb 2026 07:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKpf-0008Un-Lw
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKpd-0003E0-9Y
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770380463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kqs0z+KrVau4LGoplPf9E/+UaI6rO2GwUs50s3yZEFM=;
 b=Xd4+lUF6f1l5z3R5vT/RV+QVHzuROKARCbtfuQz/ZaT+/D/Vi0caOqhGnfIkE7DeMtpYvR
 A1T+xUtCdCghFG3FNvD9i0KO7RonhAOJan/THd7o/vnWZ1qY8NjDdi/fPbWpWB3xUkahFC
 px5wfN2ShC8lCQ17g7YhAeg46addCE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Mgt2n9-MPKC_filvWfo0Aw-1; Fri, 06 Feb 2026 07:21:02 -0500
X-MC-Unique: Mgt2n9-MPKC_filvWfo0Aw-1
X-Mimecast-MFC-AGG-ID: Mgt2n9-MPKC_filvWfo0Aw_1770380461
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4361765dc85so1851712f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 04:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770380461; x=1770985261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Kqs0z+KrVau4LGoplPf9E/+UaI6rO2GwUs50s3yZEFM=;
 b=Xr058UzdZO8WTSR0mCBCZSsAQL/d9MSA6flDwXhUcv7J3foYKT4A7o+c29mGceS/Mk
 MnWj71JpsN1clUVxIpLdwxGy9my/XJEI7dmdyuMr0mXHVNZelMtU2plBE01E/kB7WfHA
 1tadbYU7RrC0OtlbkgKCz4wZqBgDocH08pZb5x7T9DlYqPyAu7pQxayNOJ46HDLEX0jy
 +CL1W427P563o65oWMwVP9U756UCXT/1CwHV0snfsO/RPVH9e0Rl3LxcPk6UW697v4e6
 /yuVSUf/saGibTui7L/55aXM0LWdGKW6e+pupjfK82CxEoW3t7NToK2D5qD4LOTKigcD
 /Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770380461; x=1770985261;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kqs0z+KrVau4LGoplPf9E/+UaI6rO2GwUs50s3yZEFM=;
 b=c9W2KRBpTNGAGm6HbSZdFMQw45FUgkodBEyGZB8BX9IQk5+4CytNktV2Yaek6H5odz
 Gk/mWw296fGX669JQAjlsXTYqhBl8xVDDVUwBkXho5w8x2r2GoDMxsjRJyZ1Z6Tj4Q7K
 kkEUsYTRtvMuCCKOAehLPPWTZFdavKrKzMPCZOyZ74KEvmOB6YdBYJvTqkzEfF7swU2Q
 NVJLCEenQfgAyNwvvbkgEERIo7NUEVgqV3tlQVeoYkk3KyGw1VOM7Pl+ZgwfJDOzkGzP
 nOIwwwJcOyEN1fgRlIQs+932NLHTnVA1AhKdCnchc/fPstQ74nef1NHFYXHmmMF8u0um
 bG8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2qNbRN7qeILB+RAAmp+0iye6vY+DBz5ERDx2QHiwGKAC8mt3yHQ1NYTAnV3jy/JgshjobRPZR6QGn@nongnu.org
X-Gm-Message-State: AOJu0Ywdw9ptiCpVCgWfZFPhCW41lqnowXL9InBzsnIKfYR5poBppkr2
 8DWEE1dKRfgwhSpcHVV+e4HPoLupq0RhCQmb/lheQviGlzf/MWvmNgflLi21/vNkgZ2Kj3ph3eg
 4HfkjxxCobbRLtdxPjxpidq6Kh86FlZo4TjtUUtasyyEOaFbj15g5xp6d
X-Gm-Gg: AZuq6aLfaFA1+YRRGsfs0trjkPXa2/rgRpd8QPaHwO4UINk15MZpDwayFi+Fy4EhXBY
 NqdDgk2sHpnrO4rDTGYhHxPCVkdIF0Ar+4AZjXefsVBob8mq7vTEhe/Ufb9a5jhlzNJAm6c/oGi
 8DYEWEXd3JpiFtmR5pQUF7AiBtmB7o4nKRUDkgFYbtOYdzQAff2GP9BoLkodyvK8eHoOszwd9pV
 H8m84FoMY9JP/PsybVf5QCUGqQ6rHy//SQJfGRp0w7SmPt8Oxzcxq42m0VbO6dicWNpHpT2IxtN
 XnzoVdydKqBo7OaMYxsEfcA5FMqSxceVcY2LVbSsz+6DSJ3BvzglaY230WWsHZpLwO6JNZGgPPG
 /YXFCFuw=
X-Received: by 2002:a05:6000:4382:b0:436:1e6:e1e3 with SMTP id
 ffacd0b85a97d-4362938ff2amr4509423f8f.46.1770380461218; 
 Fri, 06 Feb 2026 04:21:01 -0800 (PST)
X-Received: by 2002:a05:6000:4382:b0:436:1e6:e1e3 with SMTP id
 ffacd0b85a97d-4362938ff2amr4509389f8f.46.1770380460770; 
 Fri, 06 Feb 2026 04:21:00 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa4csm5097729f8f.26.2026.02.06.04.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 04:21:00 -0800 (PST)
Message-ID: <ca3257d2-663d-4ab2-99d6-5a5ea935e4b6@redhat.com>
Date: Fri, 6 Feb 2026 13:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tests/functional/migration: Use socket_dir
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-2-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204172332.21367-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 04/02/2026 18.23, Fabiano Rosas wrote:
> Use QemuBaseTest.socket_dir instead of calling tempfile directly so
> all tests have consistent directory prefixes.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/migration.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 2bfb1f7790..0aa873edba 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -11,7 +11,6 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -import tempfile
>   import time
>   
>   from qemu_test import QemuSystemTest, which
> @@ -65,9 +64,8 @@ def migration_with_tcp_localhost(self):
>               self.do_migrate(dest_uri)
>   
>       def migration_with_unix(self):
> -        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
> -            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
> -            self.do_migrate(dest_uri)
> +        dest_uri = 'unix:%s/migration.sock' % self.socket_dir().name
> +        self.do_migrate(dest_uri)
>   
>       def migration_with_exec(self):
>           if not which('ncat'):

Reviewed-by: Thomas Huth <thuth@redhat.com>


