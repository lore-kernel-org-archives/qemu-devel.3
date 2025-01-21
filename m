Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AABC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGWY-0001Fe-0d; Tue, 21 Jan 2025 10:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGWW-0001FH-V9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGWV-00012m-Al
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737474637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ErXCtCM9L3rwkAzYrdE0OO+c9hNOas68UTSCmgaEBGo=;
 b=gFxHSY6vtq+rMzhYPINP3zMOBwhyT8dyDEINz2WzLLsd+Dk+M6DTmA7m0QlQ8RGtl8FNAX
 dwBCmbd4+CHF/g0CT7/iFaISS2w7etlN2MtYUY0fedesqmjFB2ZElRJZ3OFJZdsAV0Hsn0
 BAkQNVgfOaIcK17OsQfZBK4t2+ZnL4Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-b8jCLGhqNPeG5_uSDXDHJA-1; Tue, 21 Jan 2025 10:50:32 -0500
X-MC-Unique: b8jCLGhqNPeG5_uSDXDHJA-1
X-Mimecast-MFC-AGG-ID: b8jCLGhqNPeG5_uSDXDHJA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b864496708so1589174485a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474632; x=1738079432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErXCtCM9L3rwkAzYrdE0OO+c9hNOas68UTSCmgaEBGo=;
 b=nmLC3564WMYXnu651sAJBF9N41m5/dc47c4NZB7eOliE691iHASw+N0LkeYqO4NR3W
 /fPputQQd/ZsBFHQNX3ufNl9Kr871KAteAVpHMBrFJSdEdxlNTW2f3Hjtt7LhCOhuoBe
 1ONhvDzLYxL/LOtt2IAfYyJC/Sqd1huYl8D4toMULTcPJLVng25CrmoXVAS31aeMkdZA
 a5PitIEsxKcZbkIm0pAfxSk8YS52cDLckfG8a+rCOL6YEuGPLMs4mKROCUHlS1dJGbaR
 U4C1hE0jaognSYp2hvEImTnn1SZRIf7Ll3M531ykiy2KHSH9dsw52LAJuplXaulngoHi
 iZow==
X-Gm-Message-State: AOJu0Yy9XfIadWGJ5mFyWcpTxCCt9tBctjbYPensv8QdttLSKuZ8PemN
 pVKFY9sDzuPfWoqw6hRA9XFGSFOsA9I+Cepp19ewpKFJjrI+MBlRmaL/4ehDndZ3Pq51FuxAPkq
 uVGiOefRfizx0nTDOT1PLo9SzfqeH1yBBxCjJaV2imCGJaOcyMc6bQ7o8e2d+
X-Gm-Gg: ASbGnctTfpkZpbJy3wCCdBmBAjx3TT6ToJA/I0E42ZBco9cXaG/DftzFusxg2cuoOs3
 dk4SHK6vB+KmGHMDnlAqEnb99GI5h5lNDcHqMoKRV21Icd/oxKupL2DZkEaKT3p0OLKlxCLgE5+
 7PPQWqicuU0bFSDvu8qJg7EgweIEQ8rHJt6KRIMe1KbmxEEBuGsPyqM/KreoCIBHdAUsu3nOdjg
 3K6JL1b/EvPoXE6YG6bGLeLg1X84prqDtfAL9aJQEqZSVXzHPwUqpPSwtO6fRpmnu1Kd+ymkNZd
 GdmFjrtrusdIapgN9XZqDkwPc89wqgU=
X-Received: by 2002:a05:620a:440f:b0:7b6:7a87:744a with SMTP id
 af79cd13be357-7be631e712amr2780099785a.5.1737474632279; 
 Tue, 21 Jan 2025 07:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH10yuAuWRmmuQK4AEe+FW2KrpcMd/vMVs6LdF6HZw8S1EWAdZnZn8435jnRM5bvRoHBSEOUw==
X-Received: by 2002:a05:620a:440f:b0:7b6:7a87:744a with SMTP id
 af79cd13be357-7be631e712amr2780095985a.5.1737474631983; 
 Tue, 21 Jan 2025 07:50:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61480541sm565914585a.42.2025.01.21.07.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:50:31 -0800 (PST)
Date: Tue, 21 Jan 2025 10:50:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3 0/4] Allow to enable multifd and postcopy migration
 together
Message-ID: <Z4_CReUE4j6hz_Bh@x1n>
References: <20250121131032.1611245-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121131032.1611245-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On Tue, Jan 21, 2025 at 06:40:28PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * Currently Multifd and Postcopy migration can not be used together.
>   QEMU shows "Postcopy is not yet compatible with multifd" message.
> 
>   When migrating guests with large (100's GB) RAM, Multifd threads
>   help to accelerate migration, but inability to use it with the
>   Postcopy mode delays guest start up on the destination side.
> 
> * This patch series allows to enable both Multifd and Postcopy
>   migration together. Precopy and Multifd threads work during
>   the initial guest (RAM) transfer. When migration moves to the
>   Postcopy phase, Multifd threads are restrained and the Postcopy
>   threads start to request pages from the source side.
> 
> * This series removes magic value (4-bytes) introduced in the
>   previous series for the Postcopy channel. And refactoring of
>   the 'ram_save_target_page' function is made independent of
>   the multifd & postcopy change.
> 
> * This series passes all existing 'tests/qtest/migration/*' test
>   cases and adds a new one to enable multifd channels with postcopy
>   migration.
> 
>   v2: https://lore.kernel.org/qemu-devel/20241129122256.96778-1-ppandit@redhat.com/T/#u
>   v1: https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u
>   v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u

Another comment for the cover letter (besides the test request): please
consider adding some changelog into cover letter whenever possible.

Normally we don't suggest a changelog only if the wholeset has been
drastically rewritten.  Otherwise having a changelog would help people
understand what has happened between the versions.

Thanks,

-- 
Peter Xu


