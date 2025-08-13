Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3C3CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umJ0Y-0007jG-Jl; Wed, 13 Aug 2025 17:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umJ0U-0007iq-6b
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umJ0P-0002yd-L0
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755120448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2QoPzkI8jZlwWI7YhZmznhkU6Aeeiud9IZh/yc+Pak=;
 b=Doyed1TlbMZnCCkiiZwszvFk9zyKbMITxlRTcNN6Oa20fLeockEIqMs1IQA2Eq4p5omuLM
 +jKZQzXcgeFvmG4xi/fdfI2NtcWu6de5tm+R/4yoSd3th7NuubRZu6O3sJ2ZrawWAFMKmT
 R9YHRUZV9tNdoK6sHO1AvS3u4REllLw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Z_TLAAZ7OkSIV0PRPmhpyQ-1; Wed, 13 Aug 2025 17:27:27 -0400
X-MC-Unique: Z_TLAAZ7OkSIV0PRPmhpyQ-1
X-Mimecast-MFC-AGG-ID: Z_TLAAZ7OkSIV0PRPmhpyQ_1755120446
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71d604dcc4dso4535227b3.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 14:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755120446; x=1755725246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2QoPzkI8jZlwWI7YhZmznhkU6Aeeiud9IZh/yc+Pak=;
 b=GarOVdKCf+jvKmfLFfPkRK5ix9HGifLou4bdzew952vb9vzyo28iWYKFxcwnHizo16
 wOp3lsdwgGElw/pFw+suw+36pYqKqRTYKdAoxAxeuS0QxKg/yrZIAkHItNi9YX80fDd5
 VbgD1jCanyBIrLOp0AVzhYLryTBmhzeoNvFTb9ASBQ0GZVd34D/fmSQUTcfO8+1A6zFU
 xS/Jb8+I+SRjVZiWtNaktWPVyUb6CcAZjDLAmYHNscNZRpu1LAHC1MZKr4HfIcUlfCw9
 TeAAykQXnc+/bGjlsK7EViplebmRWtJTGuryIZ3JZiggcJ5ofmAPxQwZbZht0KLtYuT8
 sUhA==
X-Gm-Message-State: AOJu0YzjAEiUFf4IGJx+eC+WhM4ejIOs93WKEhlr6r26ne1G98B2TbpZ
 barOoav1hTcrsSX55g4fZQ2kMLGm+BM4Smqn1tXcLkhad1aVaY9B6/1RzPEjWFnm62jtHJVnOid
 s+iBqKOucY1iQJ78Dej+0OKKR00k2LYuwbWrlRhFvk6ShrykSmpnRWyOx
X-Gm-Gg: ASbGncsnIKb6ZozJ2Co+ewBy0fC3jsXfGMlNBkl8Fsk28TXl1w7s5O3B4YqEY3L+T7J
 Sq7vieiI23Ks5KdSUXEEC6G/357GbMDql5S18DcOvbsJM8bdvWmCQ7WcmlOKOK0UHeONoJweTk3
 bwObkn5W+51vH9vgSrLwimaxE9/2dVIcykKquZTQOawSIudEU5mY40gN/kOhjIZHsQBBaddOnG0
 U4nT+t/9lgnYRsofbjxD7NSDbpEgnS+2A0Jc9yGyOSu75IOOZdQODSS2mlzY+V6ijSptHqote0f
 lFf8XQnmHAQYK+708qQD3XHIQSoBnpZkXjNhhDTP3JoZloUW7M+FzWuFZZc02tRZ7gZVeX6+CPW
 nHrU480tn66CR7ZcrAXffug==
X-Received: by 2002:a05:690c:45c5:b0:71b:f7b5:8979 with SMTP id
 00721157ae682-71d635fe804mr5624947b3.37.1755120446416; 
 Wed, 13 Aug 2025 14:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESUVY2r1KAiNnyxq9NiD44Yge5c6qDzOhxQ2kQHbZGXpN037Wy/w0M+rNLkRZ3Rd1q65TfGw==
X-Received: by 2002:a05:690c:45c5:b0:71b:f7b5:8979 with SMTP id
 00721157ae682-71d635fe804mr5624697b3.37.1755120446082; 
 Wed, 13 Aug 2025 14:27:26 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d60db58f0sm1817617b3.32.2025.08.13.14.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 14:27:25 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:27:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 20/24] migration: Allow migrate commands to provide
 the migration config
Message-ID: <aJ0DO-cJdPEne7Tr@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-21-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 30, 2025 at 04:59:09PM -0300, Fabiano Rosas wrote:
> Allow the migrate and migrate_incoming commands to pass the migration
> configuration options all at once, dispensing the use of
> migrate-set-parameters and migrate-set-capabilities.
> 
> The motivation of this is to simplify the interface with the
> management layer and avoid the usage of several command invocations to
> configure a migration. It also avoids stale parameters from a previous
> migration to influence the current migration.
> 
> The options that are changed during the migration can still be set
> with the existing commands.
> 
> The order of precedence is:
> 
> 'config' argument > -global migration cmdline > migrate-set-parameters
> > defaults (migration_properties)

Did you make the 2nd/3rd the wrong way?

  config > migrate-set-parameters > -global cmdlines > defaults

> 
> I.e. the config takes precedence over all, values not present in the
> config assume the default values. The -global migration command line
> option allows the defaults to be overridden for debug.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Other than that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


