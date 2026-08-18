Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C16C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNsw-0007VH-PK; Tue, 18 Aug 2026 13:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNsu-0007V0-Mr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNst-0000hr-3r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787075158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sH4jGRUToFBj0orXrLGWyMuNGZVu4iMIa4xBaVf9OK0=;
 b=fG4384ysy5eFQmBaG1dbnENUoxwsbKGObSLUvWHw7Ba1Tg809zpQSDdopkGkqRlleBBWuN
 FGCit7LSoxkIXitxDmrac1czMgDdctTT9BJwV1aBFEi0OqeKNWHxwre+a9sskZSKkG8YLz
 +UTue0VWwPsH6x54tJ5LKjj5O1xpdOg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-yG7amjEdOBCmvsDosYH8NQ-1; Tue, 18 Aug 2026 13:45:56 -0400
X-MC-Unique: yG7amjEdOBCmvsDosYH8NQ-1
X-Mimecast-MFC-AGG-ID: yG7amjEdOBCmvsDosYH8NQ_1787075156
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92efd2ca21aso29704885a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787075156; x=1787679956; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sH4jGRUToFBj0orXrLGWyMuNGZVu4iMIa4xBaVf9OK0=;
 b=MDFGK3U64h42PITpd54ptKdqAUX3nuUlBgMYnIubml+pnMbQc3zI2nh9/Xj485+Kk6
 C8MxTBUhCZ3QmQiMQeim9N4q+ZNtMlS0MVuk+phr0q/LWn/DHSmOqUhxgypOgU2VPy/5
 1Dec8mXsl0Fc8xhjsYiYManqAfJ3sdoIaRGyVJBIJ0pqGl3OW6LDDBKwTmcKFv+2x2Pe
 dHaiGaEEcAproLj9Yf8HR8fUvAyzjv4Lk0Pl0aFY6UxKuz8/JkBXFv0qpjGZ+2GUvsvV
 57vFI5TzPB3MWE7LYONL2yNl689pjRg36u0eawGbJHD5zfFcuBqSi1G33kkigX46NXTU
 YzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075156; x=1787679956;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sH4jGRUToFBj0orXrLGWyMuNGZVu4iMIa4xBaVf9OK0=;
 b=paNM7ROuhWW6LwhFoaJz3wd5K2Ib6y5xR2FC2Z2cXlzLbErRhycL+BIu2uzUQ7LOzi
 tWA3VZ6YQtCypBjNoKYiPovin8f81haIbffwTo/nv55YqQjq7f0/SIcsSgorKuIarBOx
 N9FzTyArI+9ACa9ReFHpC/UzYXx7F2fIZN5aeMtTmbwMqUHPihWH90WatcQJL2K/fBFw
 gY/drgIN6NTVkkMJL/ZoIp5csdzq6l/mHOScFdMaJWNqg0zNrXkVRLlDBPxPD4xlp1P1
 HpsdG8S7QFSE5j6pty6yrX9xaOValTqoVs3Cx1J1Yg2PznB7O8Xm7r1GoedC6XpZAA9A
 Cw+A==
X-Gm-Message-State: AOJu0Yxq6nNPTqed51Rg6TagYyg5qxnW4QLvLegW/vYs4yExZQa87fb9
 qOO9bRv6aqF44QYdWrD1gMR6N11awzdyajrqqeC1oRw6rVmjGWFN4zn8RYhuGkt+cY525sSlGDv
 U6ITpfphJEhoP7fqIvCbebK2SdvvE7ygjvBoIvpOSB0bifO3VaCG3wImY
X-Gm-Gg: AR+sD12WFEsAwqBQOmTyp4c9TmTNDK2ZmvxLnds+S6WgcvJoD39QJFbd7ppG/zFy5oh
 dvsxAt6gdfxtWmeg6g1lWKr+BG5MK8CgtE+p8LqZBN6xdGwaIO+5KxyRWkjGZQ//JvH6Sw4RC2j
 W7ZLWHYUAzZ8NtK3n/yC8CVGqJ91idWvJRVhPxJhQ3YBSTvXyPfzF85kSWiHkMFcDHJMqzX6F30
 aKgZbJs0m6OgyNjn+wOXcW/FDignV2mzAc/E18SwOrudPZ+HWHU/kZwlARM6S1dbo1KPbRAI/h9
 Y2IJAOR+rkXSgNaKYkUPiM+hvsF0OZ8OroptcN9ezb/mHlQAI5T67MDl49JUVLAeExgU
X-Received: by 2002:a05:620a:a811:b0:936:ce2d:ed32 with SMTP id
 af79cd13be357-936d233a6dfmr3108463685a.45.1787075155979; 
 Tue, 18 Aug 2026 10:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a811:b0:936:ce2d:ed32 with SMTP id
 af79cd13be357-936d233a6dfmr3108457585a.45.1787075155440; 
 Tue, 18 Aug 2026 10:45:55 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937010c63cdsm396188485a.7.2026.08.18.10.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:45:54 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:45:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v5 00/11] migration: fast snapshot load
Message-ID: <aoSaRoZoke2WjSRX@x1.local>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hey, Aadeshveer,

On Sun, Aug 16, 2026 at 11:16:20PM +0530, Aadeshveer Singh wrote:
> v4 -> v5
> - Modify pending_bmap(Patch 6) to use variable size for better
>   efficient atomic state management
> - Added a comment(Patch 7) explaining postcopy_mapped_ram_load_page
>   explaining why cases where guest page is larger than host page are
>   disabled following what remote postcopy follows
> - Add a new check(Patch 9) in migrate_prepare to bail out if migrate
>   was used with fast snapshot load enabled, as suggested by Peter

There're something you didn't mention but we discussed it only during the
meeting about host/guest psize problem.  For this time, I'll do it for you.
Aadeshveer, please remember to mention such conclusions and findings in the
future when you will be working on other patches.

The quick summary: Aadeshveer found postcopy doesn't support guest psize >
host psize since the start, which will already fail the set capabilities in
postcopy_ram_supported_by_host().  It means we can also skip supporting
that in fast snapshot load.

Personally, I still prefer removal of all such guest psize > host psize
handlings in your current code; postcopy_place_page() isn't ready, so the
current code won't work anyway for that setup.  With it removed, then we
can stick pending_bmap with host psize, which can also cause less confusion
and make it easier to read.  But I think it's not a huge deal, and AFAIU
the code works as expected.  So I think it's fine for now.

If you're going to prepare a small series on top of this, please consider
reverting those changes back to the simple version with one patch on top.

Other than that, thanks for your hard work in the past few months!  Since I
believe this code still should function all well, I queued it for 11.2.

-- 
Peter Xu


