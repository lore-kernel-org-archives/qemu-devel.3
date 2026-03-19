Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11641090229
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3DnD-0004ma-9G; Thu, 19 Mar 2026 09:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3Dn3-0004m6-KW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3Dn0-0000Vc-71
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k2Qhuyt7tOCg1hPI6u9Nq+NxGnzghX0Hj212ukjNM2E=;
 b=VT2qF5i6Kr1LA0kS03mutPzVenFDRm9D+tGNSsHddOvkA8v0gQEDoXxefg/N9+E4HBfyu4
 NY5bnnZMrDWNXsbWbpLHGrGoZLl6eS2Efd6d3St6t97OkoDr8Vbc6XVHisd5kz2nndcN1e
 RYSOpDkuT/xCfk+xjc53aEoZkrRJM8s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-g0kCe9pPPyeZV_RxAWA81Q-1; Thu, 19 Mar 2026 09:51:43 -0400
X-MC-Unique: g0kCe9pPPyeZV_RxAWA81Q-1
X-Mimecast-MFC-AGG-ID: g0kCe9pPPyeZV_RxAWA81Q_1773928302
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89463017976so74523636d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928302; x=1774533102; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k2Qhuyt7tOCg1hPI6u9Nq+NxGnzghX0Hj212ukjNM2E=;
 b=kjDQuA4Xg9ZQCShl0GBZ7329pC6nujLrxcJs0DC0nNJW724efAn9r/yVca5BFf4MtP
 jerL/L1Y2Csprort99Bc2r6Ge52Ny26tBuaUprgWexUvB2n5YImZwAJn4pGxfGsLmcaG
 SsyhKk8no/SCWuwvtoCJU3KdSoXMvl0LuKNtw84mwsPaGzVyFYaE2EPutCDVC3If3wzB
 nhJ5A4mUnev1mZGizaD5dHIooJnPMdxS0X1CewijAkp/3fwG8wW+McKbX5QUmR0KYDIH
 ZVCtpz5Rog3wXPA5lv/SF7Dv2aEsQ3/0T2UAQ7BNj+8bSMv0hrLaDIRJC8RQ9AJkN5uz
 wiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928302; x=1774533102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2Qhuyt7tOCg1hPI6u9Nq+NxGnzghX0Hj212ukjNM2E=;
 b=RzbdG+THcu4RiyQaboKCv5LT0+3sYuNlcec3f1P6K6POX8saBGq3S6imkSGW+B8tFc
 VlEQEhzhtmaEzUOWwdgys5yV4Xu3Dx1sQlHgoXFXzneRp9AqQo3stbFrjgMl1KE/WdZH
 LJwkaJAiyrcdNg70VEY9Y30iDr2jYJxtOkbsUDpF+IN3+i9DurT9tgAvL/k1uDUwyxIK
 42Fj1nqEctCUwod4V3Jj0mq7wsPBmSp8Bjy7XEb6IsYgB1dd1rJZR01VuA0r3i/rGmxr
 I+tQg8W3tGW6kpeaFJBgKi6UY4NL7PEywstUV2Dw1+1r5aZO7I0YUXNDeNZ0IL2MP/wr
 DNwQ==
X-Gm-Message-State: AOJu0YyoHKkGkr6RZm/aQ2W5uaNdZcL0fouIlXq1GMfS4HPkG67LpfzV
 +j/PemfVmkV2mDL7a2TfushyJCGnYq654NeTqAZYzm3k2VoZ2fi0wiXHko2T+5vY7XiyiQxL5l9
 Ws4i0uqU8d4Zm8BQCib1p3Zb9YuNBxk0JSfKN4w8td2MxPVUOVUkRG3V6
X-Gm-Gg: ATEYQzxyEp6ef1kxNUZd8dS9aHDJiMxz+Giw8O9w22ibiFHyfZWFpb6tkcX28kWpdj1
 KtcUSsgcFUtyy1p94xxAoydoLVz7BP1z5c/A9vG9WPK5YcnSx6lcX03r+vpN5GwXsP2Zupt5ssv
 uxbOjP21GWycnqvQrZB9gjFLfgmFLoecusOg5sTvpIVRolyjkM2Unq61IgUGV/xWjvXCF/LLhWk
 Bate3DbLktfdJ7vfQwjgue24Eycqt23v0tlg5cxSXNCuKL1muML0JU2M4Mp/p46c/GKwi0ZAKP7
 /c1eoHatnou7mZYVIVYNa1mI4sdbECccx+/jrS59TghjFu9I4PS2tlYQsx3v4TO8jSUOgTGk0AW
 ODQyQ+tmrePtD7g==
X-Received: by 2002:a05:6214:5006:b0:89c:4d66:a067 with SMTP id
 6a1803df08f44-89c6b4b7598mr110650146d6.15.1773928302470; 
 Thu, 19 Mar 2026 06:51:42 -0700 (PDT)
X-Received: by 2002:a05:6214:5006:b0:89c:4d66:a067 with SMTP id
 6a1803df08f44-89c6b4b7598mr110649306d6.15.1773928301805; 
 Thu, 19 Mar 2026 06:51:41 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6ba0348fsm45587256d6.47.2026.03.19.06.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:51:41 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:51:40 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com
Subject: Re: [RFC V2 0/2] migration: optimize cpr fd lookup using GHashTable
Message-ID: <abv_bPLyZtfDjpPs@x1.local>
References: <20260319113830.53867-1-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319113830.53867-1-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Thu, Mar 19, 2026 at 07:38:28PM +0800, hongmianquan wrote:
> Currently, the CPR subsystem in QEMU uses a QLIST to store fds.
> In scenarios where a large number of
> fds are involved (such as a VM with many vfio-pci devices), looking up an fd
> via `cpr_find_fd` becomes a performance bottleneck due to the O(N) linear search.
> This patch series optimizes the cpr fd storage by replacing the QLIST
> with a GHashTable. The time complexity for `cpr_find_fd` is reduced
> from O(N) to O(1).

Some unanswered comments here for v1:

https://lore.kernel.org/all/aacuTpoMucQ1wrUN@x1.local/#t

-- 
Peter Xu


