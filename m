Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281EAD12D60
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnOB-0007Ru-GK; Wed, 03 Dec 2025 08:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQnO9-0007RE-SK
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQnO7-00020B-Sr
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764770362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=K1Ejb3mZxt9s6Hq8k2GbYOHpKhIqT0ccwHtr5SyWPSgJae0yqm0Paqr5dIsUQBSG0+8R6f
 feTXWHBTPndWYnu7ELG6eo2Jq12b4fcwjuqSr73VN5szP2wOYkivUiWitB7951rs6yFw55
 yzD+YYYG19irxi+97xJkilFtWeujuAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-WCcsa7_tO-uQsUbmw3Zt3A-1; Wed, 03 Dec 2025 08:59:20 -0500
X-MC-Unique: WCcsa7_tO-uQsUbmw3Zt3A-1
X-Mimecast-MFC-AGG-ID: WCcsa7_tO-uQsUbmw3Zt3A_1764770359
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a11d9f89so30580355e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764770359; x=1765375159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dm+Hde9nZEUni9HpcVxSbk5BmlR9MyZaPAoNc+ZVDLPz8EyHFy7UOtNVvdQhFXKKcg
 imgF48wUl5pW3nYQQ6PLLC/pFbLjaDVWfPxeHPs++zKntCFtAcT4u7wu9UI39IXQ17fv
 tD0qFKovuMIySvm3zlK4OvTuZyMUzE2mcpQboK0le2EVJ/rF2mmzodv4v47z9eByfWv0
 nd+V4vmNXyd0e/4XQ4WIrbeBFUkiNpRfAtcg/HwsmwsIMJcoipjQOu+zTWCaVwyabPwy
 EXk7oP0nFilss8XzJcj0bTjk00MCBJmxGJA9BbYAgA+PGSnDJncrBJyj10htoFBxoaO/
 R5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764770359; x=1765375159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZEGnXp93QpoCI7HUN1Afm0mMMP4SjWtxeobNZoyU+AV5BA4xk3mlWKnJTsaI9pxXK8
 hK8NAzHYSc2FSzIgsIskVC5oBDntrMmk4jJQRnxIqmYhY5GXn+vIlKuCsrBAQHqw5XQW
 wWSvX/k6SvPtgga9o4CRFWu/7jqRIMgTVtfJQzlF3ES4/Tkf+FgRCGDW3QYjMckkqr7N
 QaJ0+A4DyKAATcEXreXPv2Ceqou8Zw+x/FyrXJ24GCaYaU4WHFwFq2nXuMcg9ZsrYpfY
 iQX6xIsQk4yO6dYTsUeX7+kU9Go9vpnCJ/SLibnEWdEmIJaoNfCZN6z5pfpR37JOv3Bv
 Mu0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Ub0pYzep51Fh0WY51q75QikK2ge5QBQEpvGA2FXfw6sD4OVD0MVMCgDyWJ/eksv//rnw+u5ONwHy@nongnu.org
X-Gm-Message-State: AOJu0Yyde7LKD3wIUy2RJy5enUwguFQeorcf51Jf+8NIfvwCmYbfEkW0
 yUO8i3LgrduOYJvzRBXIzte5r109epp60x8lgGVGo832CzUJ4fnWOhw5XPbBOGLFErSLkmtcq6i
 sEYi69qs3ceiC/PKU6zbGOfkGvuPUZTzjjItBdvSHMBYyrxMdwMuByNr6
X-Gm-Gg: ASbGnctGWZOcicKnOcQYBuXqhpgzNs8RQUSrQdCPpLwqnUZmS51/fAGDuwPPPf9n7hw
 N//5xTCQeiZGlw7pnEVKXdvZRcdfbraoTfoNlh8DKAdjhYxAyDQJU7e7aLlFW0OjLfSL+X2GaJp
 RLenohwC4pEhnuFaMlG8Pz5kXBmBFLoKYMqBqh9MX9rt20XxMQhxcLmOJZEMAZGOlPozqBOSCwa
 +fYqM7y98vyC6sVqF9dYNF5N6eAQvoBk3RG012SUW6+0t3i1ahwxFh82Y96q9S2eZ2bEc/FN3nf
 90UUwHtkHyizzE5lxjAv2k0C3LMux8fLDpUDw4Gp1jQAmLceRn3PaulvxEqir6+yw26hu/LqDNl
 7aJwFX2nYOIn8lGCrAdiUOcGq/zCwl3qxLZg2q0i9B0JALksO3dHTcBq3YukyQdbzS/sKbL4sby
 zuANfpSohElXIm+B4=
X-Received: by 2002:a05:600c:19d2:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-4792af39a3dmr22829395e9.18.1764770358744; 
 Wed, 03 Dec 2025 05:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN8S0BRaCMjBkEMw/RIvJ6eFhHrEBKgDTu1ron4RcftS85vDSCrWhBpt0nVE/VS61XkjVzzw==
X-Received: by 2002:a05:600c:19d2:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-4792af39a3dmr22829145e9.18.1764770358341; 
 Wed, 03 Dec 2025 05:59:18 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a7a2148sm49708265e9.8.2025.12.03.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 05:59:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: dave@treblig.org
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com, pbonzini@redhat.com, jak@jak-linux.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
Date: Wed,  3 Dec 2025 14:59:14 +0100
Message-ID: <20251203135915.1566082-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203131511.153460-1-dave@treblig.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


