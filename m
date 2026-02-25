Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C7F5545F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv81p-0004LW-Lo; Wed, 25 Feb 2026 01:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vv81k-0004Jm-Pj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vv81h-00020g-Rr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771999536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BDP7tJF1c6d6G8ahfdd3OgO76ZREb0W5vKoiI7dhNI=;
 b=ZRajqsVEReBGRO9pGYalnQb8N35vI9ztfU9WARQEr6ob/MH+0iCwHJshGzte191un9LUx/
 /x0maBCFKIc5RVLy02sbVFT8mxbaqb6r6kRuzlg7tRQ/DhwP11lwWJ72n/i3ZcupY6AVtD
 g7n5p5ZGQhMlZtzMY3GQkA8Bwf3xBNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Ay8U3ldlP7CgZ6w7Eh5kxw-1; Wed, 25 Feb 2026 01:05:34 -0500
X-MC-Unique: Ay8U3ldlP7CgZ6w7Eh5kxw-1
X-Mimecast-MFC-AGG-ID: Ay8U3ldlP7CgZ6w7Eh5kxw_1771999533
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48069a43217so53741295e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 22:05:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771999533; cv=none;
 d=google.com; s=arc-20240605;
 b=XYn3pusy7y1fSzNta+a2tJfOEuULtUXZtsxvzQ8tmwsHUjEi+jPO3q96QDetbpMcNa
 8cUrgB4GSGLfHDKarpbgVBgSAdfjyJPp8j0jTUXOXfz+3pGtzwcKjGqt9GMKy+ghbEGL
 /1DKdFiDXsfn5qq7H3D/8EvO4n5kuBLDovpZf5sPMoKdvAdlogojfKa/sbVgJRJqfXzu
 clV54u6UJ/Z1T1o0UlY65/xoHx/bHBp1mKzdiaK7nkKtFNB/nqCiUBRZ21azNJ4VzOs0
 sI2V3HzFLUeergvG0VJDgZchLhODcy/V2naA2z6/JknAApkxTlPNu2i0P2SqgGz9ifJG
 nktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5BDP7tJF1c6d6G8ahfdd3OgO76ZREb0W5vKoiI7dhNI=;
 fh=wCcjNbEUcHE1fWsQwpcuRZDOxh2wcIAdW6w6x4hyjAY=;
 b=Kj9QQTnpIy0zfqwYtIMGyjBM0+t7mg4doAXdjuONcmOzjY079gm6IxnWo1/prRGGWv
 Kd4NrFljN2fGHsnIWjRRp7qn58nSjEysBQI93yDPXlRnHI5eMJqWbrGF9yxztEj1EGRN
 khfeHUsaFgRTKQq//nBqx+62xtt3omSjFQkhJrl8hhyV4Fpl4jDRSv/MT8CaJElefIMa
 kDzgMRk61EgFaqEUrcZj5pUu4Xsh2Dm8rLHTx9WHh+GK4OXlm8YGHyZ5l7msuJwaooDb
 iB5+w5ssdS2r3vZiGn8yOEJonblak9TJ/TM1YG2Qs2OhpghxXB17c8ornrKfesohEX1k
 hhGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771999533; x=1772604333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5BDP7tJF1c6d6G8ahfdd3OgO76ZREb0W5vKoiI7dhNI=;
 b=NrUr8M2EoEg7ommV8bI1+R4HV7Za7YBU5eO4XBQtaSh/TrONzs2uJYfbeyLEkLwFsn
 9j9rJanSaMjVymBWu6OzoWOrDtrSi+ZFEweCUsHlsCG38O9fT5SYc7qhFOPpLGTW6c7S
 LhjtrVCu7sUzbxEoZawo7KEttFghFt87E5THi48OD9U+zjOCip/lBrVeFEG/idguRsKt
 EHMUD0lGhTGz6HWWeRhqxyfF8C+wucYpxM9lYUDR8p1yaqLB09WyAj/WJ3+VY7QSlKPQ
 uwTdD7zfjFSTIvDnSLLV1KEjBe6cY1nS4cu//gJRwMozMDzYVw2zFdLRFvNyk7w1npV2
 dx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771999533; x=1772604333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BDP7tJF1c6d6G8ahfdd3OgO76ZREb0W5vKoiI7dhNI=;
 b=CvfaAasWYN6CR8C9lzLyLO3ff/9wPZN/g8IT9r8SNIaxLZjqnd2K83goczv/R4xwqp
 HjyC8f0xxTbNcl7OjPLTPsGQReyNpKz6nqIoUwSxG1eyiA67+IMDIWJTQEXuqxsUTeH1
 U5FkBdHck1rHQdmPbg7UT1xuXSJze8PaYlDiqcGkXYnFVmvrLMfWfXxDyaISvrrgDgCj
 mlSd2NqXk4yVGwnqEwPEh+rmL1j9XhPWSpLMWNwY5Zo2sJQcVFqFvVP0neyqw4TYQHAs
 TajEQDQS+0ii8U6dl7j3xMSJAg0Fxpfy1QMpqeQxJQlrlO75bUD/80cJH2AjeehO6SCM
 tBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhYnP+N8t3JrXdZC7V9hGwPemzWGbHbRnAfc0/oQB5TFC3pgBhcmUWLvx1xlyO5Rq/lnFAyVFdwztD@nongnu.org
X-Gm-Message-State: AOJu0Yz4tBDnamnFL6+ySAzGiS9lUAbWbgZi7WYcHcrnHfnzZeHEHT2/
 s9x7847agkVMvTzOAuhIQUWaSujGgVFkoHldRg1zugxSGBqYV9ih11L3YQtFGQcIJ0OXZ8h7Keg
 PoAhKZhbIgbv62rm5Ihf1WGrhg26A6+2+WEez+fTrgFSonLlbR5L6utTxh+PpS1h+0gSxWLVNTK
 +4vhnIPvob9iB/8ol3NjUGrWxsbYxarw4=
X-Gm-Gg: ATEYQzxSAlxoSM69yT8smnYBt/92SQG4m5wOuT4B3k5YGGebfIDn57pPY87U7jQV2SZ
 qOcV/eYNIhTdAkDIK529BbZNk/FTFd2g7Qt8VId/QMl3qAX8UgP1D3ekNb3G0EZmO+l73P9jcOu
 AoeOtyGi1f4knvU94zKH+BBTi7QLU9GwR0ARhG4mvbLJ4FsqGj/srfxMwIPfDHCta7ZlQWTZiwX
 k71KyNKje3npLzzIMQwx+R2yEe3U50Qt1WJnjd7EIIUflBrO8oUDIvPHGd1MFRk7s4=
X-Received: by 2002:a05:600c:3b05:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483bef62ac5mr16452775e9.34.1771999532856; 
 Tue, 24 Feb 2026 22:05:32 -0800 (PST)
X-Received: by 2002:a05:600c:3b05:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483bef62ac5mr16452465e9.34.1771999532439; Tue, 24 Feb 2026
 22:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
In-Reply-To: <20260225035000.385950-36-anisinha@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 25 Feb 2026 11:35:15 +0530
X-Gm-Features: AaiRm53Gv43-8Hbl8Gfz_GTNjMPUIbNyRopHpCTB62SjUbh4pTVjqy9M9J16-ws
Message-ID: <CAE8KmOyjB1NEtBVQ2QDiDZrPoem3eTWEi-Ht_mJZQNa-H=5iNQ@mail.gmail.com>
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 kraxel@redhat.com, 
 pbonzini@redhat.com, ani@anisinha.ca, Prasad Pandit <pjp@fedoraproject.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 25 Feb 2026 at 09:23, Ani Sinha <anisinha@redhat.com> wrote:
> Currently the code that adds a migration blocker does not check if the same
> blocker already exists. Return an EEXIST error code if there is an attempt to
> add the same migration blocker again. This way the same migration blocker will
> not get added twice.
>
> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  migration/migration.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index a5b0465ed3..1eb75fb7fb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
>  {
>      for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>          if (modes & BIT(mode)) {
> +            if (g_slist_index(migration_blockers[mode],
> +                                 *reasonp) >= 0) {
> +                return -EEXIST;
> +            }
>              migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
>                                                         *reasonp);
>          }

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


