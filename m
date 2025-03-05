Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C68CC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjOq-00013L-43; Wed, 05 Mar 2025 02:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpjOl-000106-VE
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpjOg-000684-CV
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741160548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67p3cb3gXMvqFK75ISBWHls5sfx2OY+9UqAGOafGxgE=;
 b=EDWKsO8PAsDmeJrwP0p1+P/jQkXgLA2XhvUUwyHIZ/7SUqKlwrO6R0sz9cwxAbjNgjUNzH
 KWm/EV95TleXiTNDXcw/AmmN9Gfp3NwB/KfqqRUrVDjlVz/oQBknxIL0T/u/hAafzza2+Z
 yn/gOPrZprinvOAlPqGcK6vWyEP2vmg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-KIY3O37xO8Cc_gOPpGre8g-1; Wed, 05 Mar 2025 02:42:11 -0500
X-MC-Unique: KIY3O37xO8Cc_gOPpGre8g-1
X-Mimecast-MFC-AGG-ID: KIY3O37xO8Cc_gOPpGre8g_1741160530
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so45380235e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741160530; x=1741765330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67p3cb3gXMvqFK75ISBWHls5sfx2OY+9UqAGOafGxgE=;
 b=ByoZZpM1Y82Br9jQdkmdKE15+kfEHDz5Yd5V1mIXvG1U/cWA2Qdv2krfxFB7cUD/pY
 GAby3bfjloZ+fyOctabw0GvpTqUWO7gL3+X0SC7/Ti0UFuA9oRRHwuvz1EEP59urug6f
 OVS2tF6tne+RkZct01G1/hArmOGGIS5fhd8vVOW6Q8Hig3WX2S2vXeAMpb1mE1x0R9H5
 THseMlCLk9DgyMasy+m9d90Pq/IZwzDAqHEL9dfXkAF/hVBYZ51uJvyPUIirXT+iUMmy
 MbXfqOjKtfR684SIwdqglVwC+TAGRID8oNUEOeJzwqA+1V8gXfvJKMtwz/KrFAxQMjC9
 vfMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC/OuWgO1zmaD7U+iZ4aKBN+OfV2L5Ongvhy7XIMNkyENGD3/NLFX0WDkdC66D+hE5C6t+pif+tqTm@nongnu.org
X-Gm-Message-State: AOJu0YyRgXd/d0BCIif7hGqoZO3tl6kQJyw/nm3qXPazbv/UXzfYe+eV
 s4Tmt8cslkLCrrVPDpGFznPOQAo1jM45ouA1psxBK0h0jxqrHQyXA0UnuoJcmzJ15VF2aPH5Ac/
 3g0FcHiCE3DvX9mg0mksgjK6mII6YaVjlwvJ+dfAoGRXMH6RA11oqwwX1m72pr1jZQI/q9X4HSF
 qPXlMWJrWYXKNhO8hllUQd0UeXTPw=
X-Gm-Gg: ASbGncu/SLfGZagFFDxRGFmKrLo2Pcu6lbo2mciGvK+g3mfupcfkcLj7ahFxyJcfaRu
 ZKBnYSVmqnt+Quhg/mNW1DV9o4uNw148HsHk5hZi0Fw/VotTm9DFmWaPWBrLqdr/B1Q4ST0qI3E
 o=
X-Received: by 2002:a05:600c:4fd2:b0:43b:ce08:c382 with SMTP id
 5b1f17b1804b1-43bd29bdd40mr14919335e9.16.1741160530243; 
 Tue, 04 Mar 2025 23:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDJ8JowTPXuO1by3OxXg902mALZt9BpktQ6OdmD5RGFmOlXIolVd63JpK597cLE1+8i1v3MP3n8LleWat/gmM=
X-Received: by 2002:a05:600c:4fd2:b0:43b:ce08:c382 with SMTP id
 5b1f17b1804b1-43bd29bdd40mr14919145e9.16.1741160529929; Tue, 04 Mar 2025
 23:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
 <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
 <Z8cRYO1Kacl7vl-I@x1.local>
In-Reply-To: <Z8cRYO1Kacl7vl-I@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 5 Mar 2025 13:11:52 +0530
X-Gm-Features: AQ5f1JrKLolZ4VirdA5vjTRDsKmJ7wVxIeISfWEYnf0pwO5qE70nLJ_wNQO2Rzo
Message-ID: <CAE8KmOyrSidELiHAtegX16gYbW6jWKL7m9YGJKzfmLbZ9x8Xaw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

On Tue, 4 Mar 2025 at 20:12, Peter Xu <peterx@redhat.com> wrote:
> IIUC Fabiano is not asking you to drop them, but split them.  Split still
> "requires" them to be present, as long as before the enablement patch.

* Yes, same here; Even I am not suggesting to drop anything. Fabiano
mentioned the following about the changes being done:

    1.  _in preparation for_ the feature  (multifd+postcopy enablement)
    2.  _as part of_ the feature (multifd+postcopy enablement)
    3. Concerns about git bisect and backporting of patches, not
missing patches when backporting.

* I am thinking:
    1. The _required_ changes are the _as part of_  the feature changes.
    2. The refactoring of ram_save_target_page and moving of
MULTIFD_MAGIC/VERSION macros to multifd.h patch can be termed as _in
preparation for_ the feature. Of these
        - Refactoring of 'ram_save_target_page' function patch is
already pulled upstream.
            -> https://gitlab.com/qemu-project/qemu/-/commit/bc38dc2f5f350310724fd7d4f0a09f8c3a4811fa
        - Similarly moving of MULTIFD_ macros patch can be pulled. It
has not changed for many revisions.
    3. The _essential_ changes are further refinement of the feature
(multifd+postcopy enablement).

* IMO, we can split patches as:
     - One patch for -> _required_ OR _as part of_ the feature changes
     - One patch for -> MULTIFD_ macros as _in preparation for_ the
feature change
     - One patch for -> _essential_  changes : flush and sync related
     - Two patches for qtest cases related changes.
This division also seems helpful for git bisect and backporting
related concerns.

* Currently we are divided over what constitutes:  _required_  OR  _as
part of_ the feature changes.
    - Hence the request for individual opinions towards that.

* If we want to merge _required_/_as part of_ the feature  and
_essential_  changes together in one patch - I'm okay.
* If we want to split the _required_ / _as part of_ the feature patch
further into two, we need to define exactly how we do that division. -
[???]

* I have shared my thoughts above, I won't hold on to it unduly.  We
need to find a way to move forward. I'm willing to go with either way
we decide.

Thank you.
---
  - Prasad


