Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8235DF5A8A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEs0w-0005lD-FT; Mon, 20 Apr 2026 13:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEs0n-0005kU-PR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEs0m-0004ul-4Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776704534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASmb26xGFCqTdLW9W8z023/i/Gx1ptamyla4vofHz1E=;
 b=f4mb+EmOm0YYHNwLDYNsDufeVJjJmiJVOGVSY/GAx+G5xvjVNXKLI39OpG2FiQjHwrmVHD
 d5ZHt39wRK/LJB2PGSXAnw0QGte24+AzLF7Z63TDucMYQpgTyarNT0vkh9s8QSrE2Iy/Tt
 g0AagK+svvnIe4t3woP6FUKTXY2g4/I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ar_euaMvNReqnHygJ_TDWQ-1; Mon, 20 Apr 2026 13:02:13 -0400
X-MC-Unique: ar_euaMvNReqnHygJ_TDWQ-1
X-Mimecast-MFC-AGG-ID: ar_euaMvNReqnHygJ_TDWQ_1776704533
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb52a22e85so205192485a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776704533; x=1777309333; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ASmb26xGFCqTdLW9W8z023/i/Gx1ptamyla4vofHz1E=;
 b=AgZKgW/OBfJgy34g7qKlmL0CKCRjUq/ks1ySwsWSnEt554+HlXTxtfWQkOLU8NfYPq
 PAcZa3enKob7s3khF4XR02fmfj6YkE/cMh+7UwrE8nU4XxltKORdlzXNadR9om89/Pin
 AJuKAZYDYhfV9MW1w4vkCahaF4L6/x1qFLa3ZF7UNSi6En99+ZQmjFBP4rgHjGJp9NSR
 flWHKfLj46Nm/1GXYOEBMLb1DI4+RgAHj9nmutyDjWCSASoAyq7rtl3kcep6XLNoSHf4
 SjSia5qXoMJzzpXM9u9miTRUsteFExvq+2n1iczImChH+UVy2LKRjDP/I6H5EJ7iv6Rl
 EZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704533; x=1777309333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASmb26xGFCqTdLW9W8z023/i/Gx1ptamyla4vofHz1E=;
 b=nJ856uZuCgbW2g/Vm4WyuxgeuB6OQR6jhXjKXrnVlqJ7OGTnTtaPGcgkb1PqbwhvDY
 8keOd1XR35U2yBfg3CIgz/ex7Rp03HMvywYiVpKbh44NUUsWGvc71Iv6i+NP7HRoWcZ3
 xE0gQ5BNySb6Owk9wdHI4YHFMeSUdIDZN667firwdj5ainRs+TeQ/RhKk8dXwc2ZKU7W
 6002D2USnEAA2e7HeGdp6uH0kbwwf/wsgQiDpc5qVcRQdVT8xK8VbBp62ZzAxCKLlPHQ
 anphUFpvpM7DT+fJ3PNBz4C24e8iE895GygUzRwcR7YH/T9jvsAegWt0QZ2zNU4bh1ac
 j9KA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BnVteJYUNkMPpdATKf0e6iuYXg8DmhtwODszTyD0n5WilNhDYmY/JcSyKtst2shVxqy4G7nTfACN+@nongnu.org
X-Gm-Message-State: AOJu0Yy/yGFyqZE8+PXgpbxe5xioh1/5uLr1fhBJQHDg2s45tddFkkGV
 9WaxBjZqtdcsVzexThYsvje3Wl9ODGN2x9NOvBii4WfSOnCkg7j+c72J90rAViJIvbsPBboF2e4
 y2ltJmU0m9OA7/WajOBY9/fUTlSR5nCRHHeQMcgsx2pFyksorNpWSlqiG
X-Gm-Gg: AeBDiesk0Si2yvMlb99Kc/bKFfBbvne+2MRiWrgJyMgTDWErAddQsmsklk6pKCZsWQ0
 vdPxEQfc2oVBqTIpAKnNkBoLKKXI1XYsscieRMaBBr6NPQuchd16VBBXmxmq/9ZTgCsIzbtjgII
 ZDeB/9ubWF40abTmSJlqu/aiTGx+gP3JCK7HXoif44MKi8upk0KAegxH0VFdT3TvZmutKTOtz7U
 PRdgiYwsMTJ6xpWUcGbFHyjPLqjQUCIJiJ7S+n006ZsxE+venNcbz0M8aMXJ6ZT2YyITF6Vtlth
 cL1k59YTNKO9mviFa+S78taDLGB2yLrGwJ0mSF3DYa14TGlWfIv0NCFOHkoz2VaugGv24JexHXz
 r8WXuz28cCB/sNgB4hCI8wdVMsNDjVt+F1erQwcqipLrD19aoGyQBokdtMg==
X-Received: by 2002:a05:620a:410c:b0:8cd:80f1:f465 with SMTP id
 af79cd13be357-8e78fd21364mr2148877885a.21.1776704532405; 
 Mon, 20 Apr 2026 10:02:12 -0700 (PDT)
X-Received: by 2002:a05:620a:410c:b0:8cd:80f1:f465 with SMTP id
 af79cd13be357-8e78fd21364mr2148871085a.21.1776704531630; 
 Mon, 20 Apr 2026 10:02:11 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d69ae320sm971569585a.20.2026.04.20.10.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 10:02:11 -0700 (PDT)
Date: Mon, 20 Apr 2026 13:02:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v14 3/8] qapi: add local migration parameter
Message-ID: <aeZcEbqJ-5EfEcIr@x1.local>
References: <20260420161958.584407-1-vsementsov@yandex-team.ru>
 <20260420161958.584407-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420161958.584407-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 20, 2026 at 07:19:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
> 
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


