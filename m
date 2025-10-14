Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF4CCCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hrl-00057Q-DF; Tue, 14 Oct 2025 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8hra-00056h-UM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8hrY-0008UR-Me
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760459214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c3yD+TzTOXeSQgQNqxetFPIiBP+plJlMotY9qn1KjSg=;
 b=PCCOxmk8HHPZcNohnpBCSDu/g5t6v0K5jamsk6f18JWTfHNFKWvkdxZKWLn3CPIz32lSqc
 FAKp1+usL9f34UHkyw7KviKdzzYmp9Xe+KECseJNNRwZhaWPuID3/TfBskmY0HOaotQ0xT
 Z5k6QWSjM/Zjqqog7wczOP+qwbGIl5w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-BiUzLLFXPMKiObBTCZ0lPQ-1; Tue, 14 Oct 2025 12:26:52 -0400
X-MC-Unique: BiUzLLFXPMKiObBTCZ0lPQ-1
X-Mimecast-MFC-AGG-ID: BiUzLLFXPMKiObBTCZ0lPQ_1760459212
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-872d2ad9572so2860294085a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 09:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760459212; x=1761064012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3yD+TzTOXeSQgQNqxetFPIiBP+plJlMotY9qn1KjSg=;
 b=fWFte/wfELZ/8glPRV3ae2IVwZll0X6UB+lSxWMuYXdhACQEPbkKOgrfxvo9OtKszL
 /QRY13Yb1AGGtTCHp1XPKm96YkChvVplL8aCUOnWSrJPspmk2elN5mEUrQkOiMTnvLkP
 RytUfuPGobrbyS9S4/vAgtraEEBmJH+USo6L28R1L/0Vo1CqN3L1U7vt70orAwMbWJZI
 Qmsa2V6JDE0EqlHC/lrKgG9UWeCErZ1rLSsk+TAiBPSgW+EYUmjx+qKeqSHE9iYXut+M
 JK0B6jIGvW87DMxGbINVpAtwDooTiAOE6hqpVsxODIABQ3jo9X7Bt9u4z1JrjsuqmD6l
 /IbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtvr/ktsJzQ79XeGCMUxV0aagj1iV/S/Y2F5Daisag4lwSv00BL662D5zLueDRqhsxJE/soazgPEqp@nongnu.org
X-Gm-Message-State: AOJu0YwE2uwZ9ScJO3xTNfFUCkOcd3emb2EZ2CJslAMUg1kALcy3ABZG
 Y+UXVxD6KEwfsme5mYCpNBdygn1iXvpqL1P0ZJjzuhMx3EKs262w1tcS0obDqtftu89STjOuwpU
 305T2CdXU1cDI/g7ucVlL34SxqFfVR2WjJmrVXlMqpkw97FfC2lN77PUh
X-Gm-Gg: ASbGncvRoeXDzvR8MnoWWsPRssVMQMJxp8Xdh8hEAG13POL3lhRWDeTzhOcSN3H7upM
 9VIKR1T3GnPxxaN1R8SeImV8uufIpUQd+6AWYgwqeT43kfhsQY8cdxHzpcY38gqHTurzJapEtqk
 LIqNLiPHyBs4ntiLv19X3415ZpA6M7Nh/2UCabYr5oUuT1vqT1pM6MSWRzMzU9C8jnqrlo2AThd
 gwIwoV1D8vlMw62qTruU6WmJW0E+40Aph6XoMxOl4/BEABOdw2h+ZyYJmjOQCRYysjtjjIVbMPa
 3LHqeBwSkegEoEqWShVa6Xsrbpz6jRg/
X-Received: by 2002:a05:620a:410d:b0:868:d7df:5b27 with SMTP id
 af79cd13be357-883521da2bdmr3866468585a.54.1760459212231; 
 Tue, 14 Oct 2025 09:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdleiVe4+ra+53GQWiyILPI0tQzdKVXQ4GQhG1hornjt0ectnl/fGNXNd1PyzSNvTAsghmnQ==
X-Received: by 2002:a05:620a:410d:b0:868:d7df:5b27 with SMTP id
 af79cd13be357-883521da2bdmr3866462985a.54.1760459211701; 
 Tue, 14 Oct 2025 09:26:51 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a2272670sm1241285885a.42.2025.10.14.09.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 09:26:51 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:26:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v7 14/19] migration: introduce .pre_incoming() vmsd handler
Message-ID: <aO55yCOtM0u6sDvj@x1.local>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-15-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010173957.166759-15-vsementsov@yandex-team.ru>
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

On Fri, Oct 10, 2025 at 08:39:52PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add possibility for devices to hook into top of migrate-incoming QMP
> command. It's a place, where migration capabilities and parameters
> are already set, but migration downtime is not yet started (source
> is still running). So here devices may do some remaining initializations
> dependent on migration capabilities. This will be used in further commit
> to support backend-transfer migration feature for vhost-user-blk.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


