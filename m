Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E64CD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJelE-0001jM-Fm; Thu, 13 Nov 2025 16:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeV8-0008O7-MU
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeV6-0005Jl-Kz
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763067903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YC03zGOlndvF12WKMPDVlfLrCJQWarSUtksVHqxWt2A=;
 b=annKfSF3uBGyxesXgNSQvLVOLPlBmDjnlOCKLKaZ0ZxlLkYmngOznaLbs3IvhS0Wm9lQ5w
 UbiVz0MaB4RxSuQ0ftwFBoDyf0qMm3mmfJvO7mJcwmtx2RP74uYKTDEkcowr7M7OTpTDFp
 zvQEqYRkyHQODCFbE2CSfH5l85KDaUM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-w3SWTTgQNkCkmojJq4xDBw-1; Thu, 13 Nov 2025 16:04:59 -0500
X-MC-Unique: w3SWTTgQNkCkmojJq4xDBw-1
X-Mimecast-MFC-AGG-ID: w3SWTTgQNkCkmojJq4xDBw_1763067899
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8805c2acd64so40027816d6.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763067899; x=1763672699; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YC03zGOlndvF12WKMPDVlfLrCJQWarSUtksVHqxWt2A=;
 b=F9Zx9Ojon15gGT44Qimu7CaDS6n+7A+hFH4ZiJgdOT5jVgiBtfu7Q/Xdzg2VtShJab
 XuGYX+Uuh2XwanRgYGvZl1Yv412LdM1ZkaVFy48CfmihFQDyKMFgLdOgezlNaL40Gunx
 TKUleNP12sZHw0YvzgKFLXTTw14K5LFi4rtBb/R+orcbHUx4Z5X14jWjmfbm39TGMykT
 haK0cbvpcCqCttpxvW/82ko2KgJw0z+xsjzC27fvCjEP6dvS4Yu/mLZY8+2G9mAOV0fJ
 6jxslAaGhB8w9n0D5wfcygWM8TFUrKldiOAWdy0WCX5FmF2q7VZ6q6VmZ5nXdmwu/b7L
 TVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763067899; x=1763672699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YC03zGOlndvF12WKMPDVlfLrCJQWarSUtksVHqxWt2A=;
 b=V4rPC6GmRpcK/iNL+ACBaVK1ahBmfLtmSI4AsAXbcmZWV7rccKoCdPdDgCKW3Z50tr
 WeaQfQsCxuG3Wpmh4DGvt1wCAUse2IngmZjD90xcbsW0crweCdsOCY948I1cUQWLeh1B
 1VigsNNocY8BfOGAI3m6W3vo6rM808jPIo+A/+SR/GUOGSoGUTQ+1Da3J41a4suMhcuV
 F09EJDMzwfQNxSdK5ALWlP2Qtbs9SxNfs9AS/p+vKYRA5Oq9Pcd/Aokd4kx0Hdvsgp+0
 0+sJMdkXmoEiR7rZX27v8j5Zt+fiF8cS39Md3xC+MGggNH5ma64zSbEazNM/YrrZjgPw
 HfUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoFxi7GDyFm3/yHbh3o2ZbuafVGkeKSNv5rMwnGugwopJWEpsQfrZTEtfwn+QT6GMc7//lqm3CGZ05@nongnu.org
X-Gm-Message-State: AOJu0Yy2MXm2+Jfr5cFOOFbnj/bZbnZD+7ZrhJaCKrY7Ln5MYOA/dcwb
 yvH81q9i+e0AEiOJ4NawOh6enR0EAmAvYqgxH0O5D77fOFI6R3GzElk5z6seBhxC89R2uDOgysd
 RAFFSiWc+67s2zxRNTu8wnEPl3ppx8kczBRljJ6to5FZsQfhCz706c50q
X-Gm-Gg: ASbGnctrz0qXHt/ERIum/Vy2sswCKVFgLBnOcLaesDEsjbu3DL7yI9t/0ciV4il0WJM
 e9TqnhucFgH+rneFWCWlmzpT57idqZJrY9jR0due8tAci1UwhRtZrueteQa0TV/GIx3fZz4cB2w
 FkVGXQe8Emw3T0B/6w8NV/izh+tzjRLyIf/moxh1F2ewKacf9rlJMiWsHYOvftif8sGyYfxHgZB
 7xY9nqd8U114WDkcuOD492G8VQnpADNIa3fbks2npbiFFCF4wYnKSOdgTd+5IqG3kIOJ9KiEIkZ
 ayo6zQSQ2/oWpghSO/TfnzfmqsW337/d/Yxkxt5v1oGzQ+OHW5spHZyVFXIG81+b8AP23/VQpiG
 pDw==
X-Received: by 2002:ad4:4eab:0:b0:87c:f92:a54e with SMTP id
 6a1803df08f44-882925ba368mr9693156d6.4.1763067898898; 
 Thu, 13 Nov 2025 13:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2e3TcmaBGsqQy9D/wBhRvIhX7q+4vqS8BKOrHe4/109hRiY9D8pOW7PdSdhqAG6u7tNkaRg==
X-Received: by 2002:ad4:4eab:0:b0:87c:f92:a54e with SMTP id
 6a1803df08f44-882925ba368mr9692486d6.4.1763067898351; 
 Thu, 13 Nov 2025 13:04:58 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede887cb42sm18280781cf.36.2025.11.13.13.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:04:57 -0800 (PST)
Date: Thu, 13 Nov 2025 16:04:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Cedric Le Goater <clg@redhat.com>
Subject: Re: [PULL 37/45] migration: multi-mode notifier
Message-ID: <aRZH9tkhTuG84CAz@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-38-peterx@redhat.com>
 <bb65bbe3-37b3-4e79-b662-82d33852e33b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb65bbe3-37b3-4e79-b662-82d33852e33b@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 13, 2025 at 03:28:12PM -0500, Matthew Rosato wrote:
> On 10/3/25 11:39 AM, Peter Xu wrote:
> > From: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Allow a notifier to be added for multiple migration modes.
> > To allow a notifier to appear on multiple per-node lists, use
> > a generic list type.  We can no longer use NotifierWithReturnList,
> > because it shoe horns the notifier onto a single list.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Link: https://lore.kernel.org/r/1759332851-370353-2-git-send-email-steven.sistare@oracle.com
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> ...
> 
> >  void migration_remove_notifier(NotifierWithReturn *notify)
> >  {
> >      if (notify->notify) {
> > -        notifier_with_return_remove(notify);
> > +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> > +            migration_blockers[mode] =
> > +                g_slist_remove(migration_state_notifiers[mode], notify);
> > +        }
> >          notify->notify = NULL;
> >      }
> 
> Hi, we started noticing occasional crashes on detach of vfio-pci devices on s390x.
> 
> The pattern we used to reliably hit the issue is to attach/detach the same hostdev to a guest; crash usually happens on the second detach, sometimes the third. 
> 
> I did a bisect and it points to this patch.  This code isn't my area of expertise, but the change above looks wrong.
> 
> I tried the following diff and it resolves the crash for me at least:
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c2daab6bdd..9e787749b2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>  {
>      if (notify->notify) {
>          for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> -            migration_blockers[mode] =
> +            migration_state_notifiers[mode] =
>                  g_slist_remove(migration_state_notifiers[mode], notify);
>          }
>          notify->notify = NULL;

I bet you're correct, thanks for reporting and providing the fix.

Could you prepare a formal patch and send it to the list?  I can collect it
for the rc pull.

Thanks,

-- 
Peter Xu


