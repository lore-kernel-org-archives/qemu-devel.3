Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5368CE9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGs1-0003Fj-3V; Mon, 29 Dec 2025 12:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGrz-0003FK-EU
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGry-0006mn-1C
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767028640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iTJ5nzZuYxlGkcNPYCY4Oxn1ZDw2jiK/T3uoGI0wVcA=;
 b=fbh7q30EIBtUoU2ZORK9VUh4tgDRbwSfW94IubnPJ2vcvApw7zswVwqnRWMh13OplYzL6i
 bXOFyHTZL3CvTpQg6oFrCct1AQKmLOsWCQhOzNEIHTSve6lpbhFUuFZ9ybWRCSvybaJLGq
 p2W8wJMKM/bLIRgaiyRlAeOs1q4OYFg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-U1MxAtJ9ML6nrjmvJpu9Gg-1; Mon, 29 Dec 2025 12:17:15 -0500
X-MC-Unique: U1MxAtJ9ML6nrjmvJpu9Gg-1
X-Mimecast-MFC-AGG-ID: U1MxAtJ9ML6nrjmvJpu9Gg_1767028634
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed6855557aso216017281cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767028634; x=1767633434; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iTJ5nzZuYxlGkcNPYCY4Oxn1ZDw2jiK/T3uoGI0wVcA=;
 b=czHvyy25WaCjVbPQyYG1zP5121TR8vxfc/pKGL19wZ+NW9n/Wga7I+hgCunKSjEBsz
 sR1sMkpa948RdJI9jSKjPgq+q3WZVnOnUrlJaYN0jsgJ53Qa2yu2O3+ugPHss0W/vd4f
 pyfyVyKhU+jp+Ay/SdBVW4JWeuv8WAHLjQLOQyqF5zppzAVB3fc+dCVlAgDPbyWdH5bk
 Zx+KvAm8yG+1Qdh3yksjjbg2E77GJ0Y3J/AwEZsFsf2TwPdsoYOR/4+YADX69EUldHDr
 gt9ni1V8o0Sj/65LP4iXmLBmCzS/jYQviDPI6XYAGhfsfcu3zfOvGagnLK66dp5tdl/N
 p24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767028634; x=1767633434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTJ5nzZuYxlGkcNPYCY4Oxn1ZDw2jiK/T3uoGI0wVcA=;
 b=xDAE3fihvrTTrLbckqmi+6onfu/WYLOatS9UU9u76AAtsB/3E/8azv3jL/UzT0WXzT
 3XMoXM2O1Rf1+wIbdQuKNm6GyCGk0FBMW7c0U+6UKsOXeK/N6hw9kQEpsjD9cuGCozSm
 EHKkWsAYuHm7SQ2YPRMZoLnH8eS46gQanDlxkmy/p37iN78dsRh9XLLJk+ezDQLniyQb
 IcEZHGjJbGltfiCWDrjiK0q0y2Qz/LLUHD+1NyjOSd2fLcKqOEZHyw36O4TYg0jYmDQS
 nczCHXB7vHcP0T/Qg5Gl0w9rfS9cO61jP6tI5K2PvITuCnQVuDtgB9aBat+NaRfTX7ZH
 75CQ==
X-Gm-Message-State: AOJu0YywvsROvpt/a67f+n3dsO58FbT0ci5UqClLg5KoshORwqMVJvhf
 ea0Rr/ysc76y5nhzbyKVU65I7x58MiFGyPxQk1qtXyv85SwIz71oeuR6h1xSKcDAe8MlvGTlixE
 Lek3cOxNwsrYAQt3hvqDueSAVXO91qiD4CbfRHrl5eCG+7Xy6LS+GCqi+
X-Gm-Gg: AY/fxX7PbRFdBbpUczdrM6EvW3S/hkVZqvxUVWNqAyX+BsalrtT+4VLL78lMZ9bC/BN
 xuVSkHgcU7gW5F1t4v3595QA9ssStm79CK03geWDEQkveM4QSZO9MbQXrZUDA5BSvRtDiRnrGuW
 jok6uO8mn9QngxzwwTmDm3XteYzjsUVXZzX1TPm6hXLPg+OfgGbDlP9SeQqYsda/RTBMpLwPzC6
 Yt00tNAkaqZCffY95tRr/r35U9EfMm/Je4F7eOnc2qTxF56q3zEi0zT8gRqJd6lUxFjRDMhS3vg
 lD9BihXkabrnkv+GccrP9FXwKzkA+pby5lb2Ol8G8DlkpPqV9Pmkjyy3SRQ+XwzOdgQiKcR8gCF
 +bXY=
X-Received: by 2002:a05:622a:15d6:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-4f4aadb1032mr544278361cf.33.1767028634441; 
 Mon, 29 Dec 2025 09:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3YYx255VsEDOKutgFZMPAt3mKudwn+ZzKsvER10q0H8Bg4FF5M2AUofPOSGEEGChrHLXI6w==
X-Received: by 2002:a05:622a:15d6:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-4f4aadb1032mr544277961cf.33.1767028633974; 
 Mon, 29 Dec 2025 09:17:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac62f973sm232849301cf.18.2025.12.29.09.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 09:17:13 -0800 (PST)
Date: Mon, 29 Dec 2025 12:17:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 11/25] migration: yank: Move register instance earlier
Message-ID: <aVK3lpIGhfypr-Qc@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-12-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:13PM -0300, Fabiano Rosas wrote:
> Move the register_instance call to migrate_prepare() so it can be
> paired with the unregister_instance at migration_cleanup(). Otherwise,
> the cleanup cannot be run when cpr_state_save() fails because the
> instance is registered only after it.
> 
> When resuming from a paused postcopy migration, migrate_prepare()
> returns early, but migration_cleanup() doesn't run, so the yank will
> remain paired.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


