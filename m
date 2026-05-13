Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60962CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGNq-0000Eb-9E; Wed, 13 May 2026 16:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGNo-0000EM-PL
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGNn-0002nE-8o
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778704842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWPl3cnDu6PAQFWgIAXjJN3A3b9ZlYmKF3NMGd71xGE=;
 b=dk0PatApni8N7sCruZD87ym4/3BlCK1qAv6Yrs1vR3xFePceqjJ/twtjD5blg/WzRWGP8b
 fJRrbp6TPzAnFyEkvT7kqgxXvRIhVvYWOhGaOxmfH7ih9AxyDEn4Djv5NuAKTtsCFGaXoV
 imEDQv3QXvd4fKMaG5qkYvTUhk9YAnc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-tbF29kdTN6Ca9UJTPohZfw-1; Wed, 13 May 2026 16:40:40 -0400
X-MC-Unique: tbF29kdTN6Ca9UJTPohZfw-1
X-Mimecast-MFC-AGG-ID: tbF29kdTN6Ca9UJTPohZfw_1778704840
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b7a1ea06bfso160774936d6.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778704840; x=1779309640; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XWPl3cnDu6PAQFWgIAXjJN3A3b9ZlYmKF3NMGd71xGE=;
 b=cUtRZr6j0NjH+Gyy67EPIxc44jQ/R1RDF+Yt3WsnhppGkSNsx2OKqSzp0Gis5D35HM
 nOM0qdsBwMDFoFIkbZl1ZOfU4JZmx3cTvaAc25GV0LsVntty76sygzVfTt8wz7Z2iD3s
 0GPCGDhnU1TaiD1kIouHBcLCawE5dm+lIUQpZp0tMKSuocyJFdMLRr49ZIZ0N7yAx8re
 op5F43NArb0J4R+KccvpLm3u7ei2UmdPJgDW74HO/scmGpAm6RktTJ6usxUtEECY0/BQ
 E2Dpt15Z/lQnFApTUkYFyQ/AtXmujCCvK+21ZaXBi/5130aSMXXNRj5IpZhZY1+cMrzk
 Ywnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704840; x=1779309640;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWPl3cnDu6PAQFWgIAXjJN3A3b9ZlYmKF3NMGd71xGE=;
 b=QfVXHCCGDx+wkR19j3s0WFu4QPE34VqCkfxPa5S7ml4F1xhENanwLK3p13zDTOx3bN
 q00FAdelHcMF3QIu8TPFTdJqJGeXSJxXO5Ov8Wr/059OauYWI4NFZey71QRPTOS41iIs
 4R0KzOLwG9zPW/fBoRjt3vwiS7LN5GeYNWnDQcBD83huaAJGWk/eqpraDZOkfYZtY6/Z
 2nxQJOhGFCCeX/tqlrxbUEKsxtG0pLAr9oNYSCPU0vHx/nPsSIZDglJmDDucO/fcYq7b
 ugicLIB4zd7o/eyNMjQxX/JVIzRpGkIYMd2X/CGe0g6JRBf1smskhy5UK5R6riRS3Xra
 EyGg==
X-Gm-Message-State: AOJu0YyDYBobV9gxQqX4kKqzb5Bz3puqs6IDuW4/yZB3wvoWd0MTz+Ol
 mDMHjcaVNGUoqLDNIjJOZIM2QHO3cRzuJY0O2RbfLRTxLV3gFovYBUqnTRvQY4sje04lJ3+8nB2
 OeO126dV4iD4aIYkbEuMpNdvofDFPg22iI5356poKvJqCPm7NjEIr8grPQFUPGNir
X-Gm-Gg: Acq92OEHwCzLYTYikxqTZ3icAMNUUE0D9b5sQS9mUJnmHCykfz+iEtJ9lRWMtPM94dQ
 wO7a50yFGS6RgUi3kRjmebJag+8ZQ5TOt4U+d14ee3wiZUETzs/mYBkGKfGrJYdyaey9SE2tyca
 42racv/d8gQ/1i86g87GNLumloMMMrIuGgWMF/AtLnZ3X56nt+99gQ+MNHBqvceK+MbPtsnHbCS
 +6vTAmI6PhzT+DtBhvTSJp/5a5xMG44lcVmeIHY5nI2sPFgM7a1xgxPX2g3zsHjrdbgAe60ngtD
 EbCO30YIh1KkejUjLFBx9qRusJtIa72/s6tyVw1MsCAIKTgYuaxW0/fEHTQSzlonTO33Y0BSdBe
 3r9L6Ymuvzmum4gss6SjVd5TyMEcQICVRDprBeLF8UeASfxo=
X-Received: by 2002:a05:6214:4289:b0:8b3:fb6a:d370 with SMTP id
 6a1803df08f44-8c7bd0e15b8mr82763706d6.37.1778704839822; 
 Wed, 13 May 2026 13:40:39 -0700 (PDT)
X-Received: by 2002:a05:6214:4289:b0:8b3:fb6a:d370 with SMTP id
 6a1803df08f44-8c7bd0e15b8mr82763196d6.37.1778704839296; 
 Wed, 13 May 2026 13:40:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90bb80ed0sm5510216d6.35.2026.05.13.13.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:40:38 -0700 (PDT)
Date: Wed, 13 May 2026 16:40:38 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 05/13] virtio-mem: remove
 replay_populated/replay_discarded implementation
Message-ID: <agThxuVtPEB7NoWL@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-5-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-5-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 04, 2026 at 04:30:11PM +0400, Marc-André Lureau wrote:
> The replay iteration logic has been moved into the RamDiscardManager,
> which now iterates at source granularity using is_populated(). The
> source-level replay_populated/replay_discarded methods and their
> helpers are no longer called.
> 
> Remove the now-dead replay methods, the VirtIOMEMReplayData struct,
> the virtio_mem_for_each_plugged/unplugged_section() helpers (only used
> by the replay methods), and the virtio_mem_section_cb typedef.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


