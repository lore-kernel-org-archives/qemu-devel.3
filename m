Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6FBC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8Yd-0001dd-CU; Thu, 20 Feb 2025 10:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8Ya-0001dJ-6O
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8YY-0001ph-QP
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740065621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yapTsypdN+ODW+VR9R7f52sFqzg14QfMKnnbVSrKGkw=;
 b=Z2+VIUwxK7egwbxKutzpCP/OnZpOZSFkZFQpVZDr3gAgojQ/vxeTZb9yQohRO7kPsEcsdt
 rJMWy2XtCmB4UC5xk2WJDs8A8fimKOeZ8Mj+yH6uOLNyR7voknMQAHALS92MlCNx4boyGd
 XEUFVsKguosWtIHDUIZ6xt3+rtYtlz4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-KYzUp_SbPd-2Bv1G-URDLw-1; Thu, 20 Feb 2025 10:33:40 -0500
X-MC-Unique: KYzUp_SbPd-2Bv1G-URDLw-1
X-Mimecast-MFC-AGG-ID: KYzUp_SbPd-2Bv1G-URDLw_1740065619
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0a79e6a7eso180145185a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065619; x=1740670419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yapTsypdN+ODW+VR9R7f52sFqzg14QfMKnnbVSrKGkw=;
 b=lOjmty9eIy372UHWcPOvnht8iaTahknwDuC3M2RmZW/N+f0vTlCtJ3JSa6+ECNAzDK
 /hOoBV7SVM7xT/SSzOtQAoxvCh6Ff3+kD0P3D+mNBmfIuWP5FTKZtIMWPqUXIgvmYyMY
 62UxosNHOScQ/8B5Xhq8sUak9yfKJ3ulqY22An+855bB+9Dl4qvEBZRFQGIHLKvBBBaH
 3IgGDbW4KWcxfu12kcHoGl9x/vzG3fcApwgvN/5Kh44mkc5+tkfSx/wN3LZEY2kN+lfb
 FD02skW9oxg/cRCtycJXepnGHC4J3VA3BDJtuxL56nZZcW/uFTmzxWqpkz6B7DnUYWt6
 uh4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoCT6zT8aR2A5TJhEhd7393cR/qlHin3olkbF8KcEhzbKLNSn9qEoaL8k1h9/7oLmAK8S0tcScNYjO@nongnu.org
X-Gm-Message-State: AOJu0YxtYwpUMCbfe0vPQiWkaQArkKBbh9xi3+ncD6RBFW6q9LcKdoGi
 F9gfYmgII7NY+/qyQOY3eOh7FJUAaNkHPw21O7S0ivpiXGvz7CTxIyNuwl4dCeemk142H9FHhRh
 ckxn1/p7U/aydqWAr+aG1tw/ySI7ez4yfe/bjWdFXPjMN/ACVIJHs
X-Gm-Gg: ASbGncvvSpMxwqD8amYJDd+2SyPg1bxlI2hBoegXKsPwdLwqXgRaAUhoVhH6X00b+7Y
 bcZHW6wWxTlCESCBx/Xr82/cSgbAzu5gYjrPfdurV1XQs8sSnO8Q22LykejVRJGKUbJR/0nNbNI
 Z42fTZNVVSuYElCKyyDbCz5ZsqjdZnz7RjE5NWwrISrIU6r5TY3sSLTC/9y7DUvbHfJc94j49vK
 w0CNUIy9P/IdiD0YV+JXt1tL/qDdJd80fPZc3i5WQsSFe+FchluqPuSHtc=
X-Received: by 2002:a05:620a:2a06:b0:7c0:b08d:2446 with SMTP id
 af79cd13be357-7c0b08d2b2fmr1408316085a.46.1740065619660; 
 Thu, 20 Feb 2025 07:33:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpwa1ATPvk9mmQfg6psOz5K6v57AHZi+ZxCvKNMLCDQLSkzDdPX/DoD8jkoHkVkmWf6i1rdQ==
X-Received: by 2002:a05:620a:2a06:b0:7c0:b08d:2446 with SMTP id
 af79cd13be357-7c0b08d2b2fmr1408313585a.46.1740065619405; 
 Thu, 20 Feb 2025 07:33:39 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b7a62d8bsm204851285a.8.2025.02.20.07.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:33:38 -0800 (PST)
Date: Thu, 20 Feb 2025 10:33:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Yan Fu <yafu@redhat.com>
Subject: Re: [PATCH] migration: Fix UAF for incoming migration on
 MigrationState
Message-ID: <Z7dLUCdhRyby3Tp9@x1.local>
References: <20250220132459.512610-1-peterx@redhat.com>
 <87h64o90dn.fsf@suse.de>
 <gtxeejfyyr4v7ebwtesl6zn743knf4bp73balfmlhlgxm3a5jw@kqig7553jjen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <gtxeejfyyr4v7ebwtesl6zn743knf4bp73balfmlhlgxm3a5jw@kqig7553jjen>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 20, 2025 at 03:48:17PM +0100, Juraj Marcin wrote:
> Maybe it could be also useful to add assertions to places where locked
> BQL is assumed and the assumption is not clear enough. Then, when
> something changes, it will fail with a clear reason instead of debugging
> race conditions that might occur.

Right.  We have plenty of those already:

$ git grep "assert(bql_locked())" | wc -l

If there's some places that we find that is not clear on BQL dependency but
relies on that, we can consider adding more if that helps clarifications.

-- 
Peter Xu


