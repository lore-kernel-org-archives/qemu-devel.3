Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC83CD4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgW2r-0003fH-MI; Thu, 15 Jan 2026 17:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgW2p-0003by-Fq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgW2o-0006GY-1Z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768516941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1dAWb+m8K6g51267EIb6nuvKAfhPimcxXslolI7Ibz8=;
 b=hHcYqjlq8Yp4BFQdluc+0j/bwbBLZ1ku9V16KbTPUbvjEHKtRnC8RNm1S+rBMs9WvsTRLW
 N1mMKh7OAiVjSef7SButh9+hKoAixy7g4miSFhbvcKB0DqBaBqzoDOCa5BRP/hs6K8Mrdf
 LlEjLOLyeQaaUu2e3EOJG/0Oi3MwzZY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-IC9DVX0JMG-ctZGgvsAIdg-1; Thu, 15 Jan 2026 17:42:19 -0500
X-MC-Unique: IC9DVX0JMG-ctZGgvsAIdg-1
X-Mimecast-MFC-AGG-ID: IC9DVX0JMG-ctZGgvsAIdg_1768516939
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5014d8b3ae0so34122341cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768516939; x=1769121739; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1dAWb+m8K6g51267EIb6nuvKAfhPimcxXslolI7Ibz8=;
 b=LXm45RmlDYVvhdotMuuW4zQQ40dgvTqiGtsBvDhl98AFZUqbPBAKqDSL0auq4ZeamQ
 ah5LYZ5NZlyWspHdAIwRFGN9LQ7371Cyy55mstSi9hxCduUJD3kyZEXmzbbFa27nLYHf
 oY3fps+3Fbzj2tX74XRnZbHvSQdFpznaqS9c7VC3b4ovRBKwG+e1vNfp9EQp5kRWkzy9
 hbrU1Cl8SgWWAz7B8SJEEIUUlr33E/gyx+OJeAvvSPd2/zjbsDYaBoyi/Kd9YFjkVvIe
 XaqdfN51Y6H9tEA3GwYc2xBiex74mpV2+KKxNEXEdF+KjGA9Ye5GZoyTgYcJHerrqoMV
 6WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516939; x=1769121739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dAWb+m8K6g51267EIb6nuvKAfhPimcxXslolI7Ibz8=;
 b=traZnPbgThDTuaa8DKh8U5fFo0p68mPhd5DeXqG6Nj5/W1IZ6BK2Z/PiqMgpLMpO1p
 L8CZi5bKM9y/4/UFrYb/t7xiXvLVnd3NhrflaTCAJsMzb6X5eXqkEkmY0gqSg5PAydOf
 LkCFYHI0vcCaAQpgB54/+9tqoXzXp3Jb82G/WhWe16GbPfRTUaedG1FG9FYktdrKOVus
 ra4MAnYsXTUE8k6j8eQjHqlWZaUy4bwtV2pXbBhQlrhWaTagfPHL2jFcfZKBnagmrPwX
 Djwe7wGoey0a6ZJ3wZ6uas2jVh8xxwXsGVsyNOVpRb5iOswog5AkrGTdKpwuReD6IVAq
 ZG7w==
X-Gm-Message-State: AOJu0YwhTxJQWsLAIESH0bCJhoV5PYx468KeXoZaKbhFQ+XkByNPBpY1
 tmTw4RiO+2NywFuFCrr2YRVeMUvuspsYNvsMuuFD5KddqmTkDzZsBp7857LjEftx21mJOli9Fai
 EKuPIWeMvghmlyIV1H4jfX8AoVME6WNmxAqzYFIsQAWLSkAmBUhQmmC/L
X-Gm-Gg: AY/fxX4QLg567QciU+U5Oa/VzpPDzyjLc1ZWLnvFi9HCuWXN0GhmhxpKvpOPdFnevtu
 D0ODG4JDMhZsZZrcDZFkv4Iqi2MZ/pXTb85/rR/jZ20xVAlT0WCEvt+VjNLEB2Ncj7lG+dPOesR
 lfTnmbFDlMI56aNoQ/WZoBVNaPPZfQHT5EAuuzknSKeAk3V/WwFQ1xRmdiTVlawAHQMlS3rcD0S
 tN4xAphsbAjlbqfEJq1YdLj41b8N2lH2JZOuw8p6diIpjcCzW22K32aUwEOlbzyQ5YhS3IxOxMt
 gKXX1KwmACNIGfMs/ccWYsEhbKvNwqU3WPpmBK9mo6NSUKs+oTor73hcOl/dJV15UzpwcGpwfCe
 xMFs=
X-Received: by 2002:ac8:5a08:0:b0:4ee:1875:42fa with SMTP id
 d75a77b69052e-502a15ebca2mr16419781cf.1.1768516939238; 
 Thu, 15 Jan 2026 14:42:19 -0800 (PST)
X-Received: by 2002:ac8:5a08:0:b0:4ee:1875:42fa with SMTP id
 d75a77b69052e-502a15ebca2mr16419661cf.1.1768516938861; 
 Thu, 15 Jan 2026 14:42:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6ca6e0sm7070486d6.42.2026.01.15.14.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:42:18 -0800 (PST)
Date: Thu, 15 Jan 2026 17:42:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 3/3] migration-test: Add COLO migration unit test
Message-ID: <aWltRH6Nra-Tji7w@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-3-f9734bc74c71@web.de>
 <aV1qf5uDYYiGrqR_@x1.local> <20260115233500.26fd1628@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115233500.26fd1628@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jan 15, 2026 at 11:35:00PM +0100, Lukas Straub wrote:
> > > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > > index 8c1fc6e009f16dc05a47e917167f62e0250ca992..08bca49a8980f9988be9447acf54b17acd56da94 100644
> > > --- a/tests/qtest/migration/framework.c
> > > +++ b/tests/qtest/migration/framework.c
> > > @@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> > >      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> > >          memory_size = "150M";
> > >  
> > > -        if (g_str_equal(arch, "i386")) {
> > > +        if (g_str_equal(arch, "i386") || args->is_colo) {  
> > 
> > OK, one more reference..
> > 
> > I'm curious, why Q35 is not supported?
> 
> There is a bug in the emulated ahci disk controller which crashes when
> it's vmstate is loaded more than once.

I wonder what happens if one does a loadvm on top of a migrated QEMU, then.

Is that the only device that is broken?  Could we fix the device instead?

Thanks,

-- 
Peter Xu


