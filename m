Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74035D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 21:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQBoO-0003xF-65; Mon, 01 Dec 2025 16:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQBoH-0003wC-QZ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 16:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQBoG-0006c5-F2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 16:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764625912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96ny2aMnbPzMtA2lfR12EhTGCBe96HgkMENghITKU3c=;
 b=cml8b0x8+UMrPDaxy2wIw/aKVaTebx5QrO4TN+82OqbieKIJmDlOcFSU7ypGqIzY924+5O
 XX28uCLcTp88KyEjGr4t35FpE2rH0s42fBoIIE3JFJqMFZdVxAlbHwY4C1Dty1l+d2fQeZ
 k/5u9n14aFi7FzsY0TS3iaAt0HwKQQ0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-aNg3mJIlP8Gwj7j9HOZGSQ-1; Mon, 01 Dec 2025 16:51:50 -0500
X-MC-Unique: aNg3mJIlP8Gwj7j9HOZGSQ-1
X-Mimecast-MFC-AGG-ID: aNg3mJIlP8Gwj7j9HOZGSQ_1764625910
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee0c1d1b36so91564891cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764625910; x=1765230710; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=96ny2aMnbPzMtA2lfR12EhTGCBe96HgkMENghITKU3c=;
 b=cHmBQLEs13UHhjkdIBDs8Pc3X8I66DTq7O/3pBxhI0fnLn6RoTW6MnS/tzflDaR1Td
 jFAly+m+/qYk0MNr7EyZFM1cxDEmHl7auh+SIrPEwl6usAlqKOCZNP2sLVzhYWXtTXtC
 ylr1jgPs6N4bYXePFtUWAKhXBoQsbP2H8H29txPur6kj6jXiOnBjhwYS+2HwJXmxLcqv
 lm9C4kU7Gic9McrfZo0/rD+9qfXGQAG5Mqe2QdkJcI1BfJLddrrcH74raE5aQh6DElFs
 rvu0JtOIGs9fHO9jdtwr1+Lbxd+G4Ci+/9uwYxmPXGKQ+WG2n1x2swzminnlO241nqgN
 f+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764625910; x=1765230710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96ny2aMnbPzMtA2lfR12EhTGCBe96HgkMENghITKU3c=;
 b=a1F3CwU34ULwpWbTGriU3uSjScbtikdl55JXbud//igXgaOKJHDby/l7MsYSgXKdQM
 1OKnjye1W+fJ8wrerJsP1VC57uXr/DhSF+TOrxrDU642/dFvSye3Thm52Hn3MiMJEOoy
 M5Irurg2WZrQlUZ2tiwXn9JG/kAKr94WQLlfM+jmUa765mhM6rKDw8qm0aVhk0TqAJXq
 v4b5fiHsaD7aIifJa838AI6BW7prhYxYmZUN4AOyrLUvnvRPMG8RsLSTyFvUGmoizHcC
 wnF/2pY9jKIjHbWv+7si3z0MFacgcpNeUVqmIcunzzblquYmoE/y7c0QYjWViYjZxwV/
 l8/Q==
X-Gm-Message-State: AOJu0Yz6w3XcStAYR6IFoJtU5XjGUldDxw3KjWwm5pe5ot5GtrteWPZb
 JEFF65atya3qpM9jpgSmkutmmBLPXWdyDw2nOeU0jT/hfC4e0BnP08llM5XNuRNOcNBzwickq2/
 KE9C8qjFFWpZPEdItLeFjBlS4jsNHEYSoCJ078bdjOXDJEEIiVfAB6+km
X-Gm-Gg: ASbGncufgK0wL/u3QpxTyxpSVf1ZEKE6dSg+JzgHNRErnOrukMmrJUoGBRVlLGkeWBo
 gDgiQ/b2qgh3219ajgdpw2KXHIjb18vIEtz2Nndl9I8nZFHkUaZ5GFEYGCB+wTsQu61QsQ6Uw9F
 VlOcFvoRVyp+wiDqZgyI19g3TOT6K5KXL7jkReWY06wM8F8PfcjR6KJUuWLY/6LBrS/yr8kmH3W
 dq+adgwmo+1VxIzeQI575qVvgTfGitB6Q+6sS/ZxgOx5xnD69h0qqQ4wlZNST1Zzywdfdc0llDL
 v47zgGGjzMMci2XJrfaNHXcrIoF75cHrmAzz0NqxvscaWhsDuuiMFhjf9VHQis3ntf/PfH8jBdZ
 X1Es=
X-Received: by 2002:ac8:5904:0:b0:4ee:ce3:6c9c with SMTP id
 d75a77b69052e-4f0088f0d6fmr2163941cf.2.1764625910183; 
 Mon, 01 Dec 2025 13:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp8ObykFdecYmb4Ogt5pINYfVnlgsjLXpU1nrmvTQQbB8uoqLMx33a6S9rUENsx3HBsl+FUQ==
X-Received: by 2002:ac8:5904:0:b0:4ee:ce3:6c9c with SMTP id
 d75a77b69052e-4f0088f0d6fmr2163491cf.2.1764625909590; 
 Mon, 01 Dec 2025 13:51:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd3443375sm80500441cf.29.2025.12.01.13.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 13:51:49 -0800 (PST)
Date: Mon, 1 Dec 2025 16:51:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH v2] scripts/analyze-migration: Support mapped-ram
 snapshot format
Message-ID: <aS4N9J_B4GbSvYTh@x1.local>
References: <20251126155015.941129-1-pzmarzly0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126155015.941129-1-pzmarzly0@gmail.com>
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

On Wed, Nov 26, 2025 at 03:50:15PM +0000, Pawel Zmarzly wrote:
> The script has not been updated to read mapped-ram snapshots and is currently
> crashing when trying to read such a file.
> 
> With this commit, it can now read a snapshot created with:
> 
>     (qemu) migrate_set_capability x-ignore-shared on
>     (qemu) migrate_set_capability mapped-ram on
>     (qemu) migrate -d file:vm.state
> 
> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>

queued, thanks.

-- 
Peter Xu


