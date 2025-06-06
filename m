Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E96C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcYE-0001O4-De; Fri, 06 Jun 2025 15:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcYC-0001Nh-N6
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcYA-0004JR-0K
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749237379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OAwyZBsaYIWXdKLyez2QnjLsyEzl8Wx6eADqoOuJet4=;
 b=KYWXLdHCeWBUqAFESMq1yjLK5FpCErMlrPx/bCzCz5ZOVrf2AJ9rg+/t5Cp6b3sOXs3YEt
 QIcGo15YeVDU49NtXpiGtDK6xTgnmAlSP/2AOIbRFJ9atFVfcUBCQWhuX1o/+20ps8YWeD
 8YbvBKrHqLV4/rTVBH+ylQ90yQJnNa4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-yrUcBz5yPruLaW81iL1gCQ-1; Fri, 06 Jun 2025 15:16:18 -0400
X-MC-Unique: yrUcBz5yPruLaW81iL1gCQ-1
X-Mimecast-MFC-AGG-ID: yrUcBz5yPruLaW81iL1gCQ_1749237378
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7d09bc05b77so385142285a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749237378; x=1749842178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAwyZBsaYIWXdKLyez2QnjLsyEzl8Wx6eADqoOuJet4=;
 b=bY0iHshxBviFCmAU4Ha6ku3q8cFu0NVt7dDx2sryD8en5waw+mxnF7EzLIXEjcCiFU
 LKoXL4ZphbiIGWz1gTgXJDVpLqECHGBO8R0uesc/8OTNMxr6N6hh2l2WKZoBOtCEwy6r
 zU+8xsOX2Pfb+5Gjn4Qm33dLonMyNJSpL7bcX2XQyy5evOuOqdINZhW6ykCdad0/DKS2
 G0C7QHAk2iPGxODkYzOz82gUNqq8MJeRk7ifSIKokx8vU64kJA5d7OdWqyx8WxbOTx2S
 akAuchwC7MNOeyCW9rbrlsY8CFKOxycD+Tr+1zlng6DGB7O7aJ9fZup2KVzsZOrCHtWp
 XoKQ==
X-Gm-Message-State: AOJu0Yw/KvlA/Af/bY1MnxXoODlus4Gxpk6mmWN1I0gx8rbshs1NCbLx
 KzzqcUSSQJHwXHfjgLx+gnGt2GWzZ+LljG3efl1A4cB0wVbTh7SzvbNoVTMjoqhLTAV5CkN4GRQ
 BxPexdlazPDjc7t4OhPTIeRt5fWJbKNrlENUZdi+V7bSJ0BbHW7H4xbp9
X-Gm-Gg: ASbGncsIV46wgcKQjAbYPtd21pZWlVRy/DqjtR5lCYtAG5E9xVfh6SvEfaYp3j0hUzI
 CmPrwaQWNw0OAuogf5KEySSU5SazSgyniH5AixXh+3OvMj77sXw9Vh38y9k6q+AzAdz7mluoCjb
 UmoYZL1QdiF7Y8Z2JF1itdBAO450qXvm9GubRHbsgfAWZW4SqqpAzN6chaGPhQj6sCpTh6Sanf0
 wizhDe0bmgTqJsH/vNHMqK0wetsjNWE6UmUevBnHu1i16egBmbjUJzmOmXfNgZcX1znkAHoVnHu
 Za4=
X-Received: by 2002:a05:620a:40d2:b0:7c7:a604:d28e with SMTP id
 af79cd13be357-7d2298ca8damr644519985a.33.1749237377793; 
 Fri, 06 Jun 2025 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHueYYfg3CR1bpEdNpp6SWcQMkh9l/wT9uS7jseJf+2fGG4x3DyNEJd6C6kv9qX1nTuTS8GqA==
X-Received: by 2002:a05:620a:40d2:b0:7c7:a604:d28e with SMTP id
 af79cd13be357-7d2298ca8damr644517385a.33.1749237377469; 
 Fri, 06 Jun 2025 12:16:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b800csm171347985a.107.2025.06.06.12.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:16:16 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:16:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 17/21] migration: Remove s->capabilities
Message-ID: <aEM-fgq-i-lis_Rv@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 02, 2025 at 10:38:06PM -0300, Fabiano Rosas wrote:
> Last patch added capabilities to s->parameters. Now we can replace all
> instances of s->capabilities with s->parameters:
> 
> - The -global properties now get set directly in s->parameters.
> 
> - Accessors from options.c now read from s->parameters.
> 
> - migrate_caps_check() now takes a MigrationParameters object. The
>   function is still kept around because migrate-set-capabilities will
>   still use it.
> 
> - The machinery for background-snapshot compatibility check goes
>   away. We can check each capability by name (if s->parameters.cap ...)
> 
> - savevm uses the helper functions introduced in the last patch to do
>   validation of capabilities found on the migration stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


