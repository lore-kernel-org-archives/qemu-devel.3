Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1005C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Xn-0001xq-WF; Fri, 11 Jul 2025 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9Ow-0003pq-0U
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9Ou-0002N7-J7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=i/JLPiPwOvcKn9sY6g3jriJrBOWsJsc19uXDTv1NcvGwSWRyWiOXBwzyIXjzVwa1Hj12v3
 pZ8Ae/RaGMoKBevDVKnuBiNfrjBGnCP43bzhC3xKh4Mi5O449oo5Y4ph4wxmXyGFMtgA9P
 8W1/3SucTdyZLQSFkoUhrjcaE0xkbcQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-CS0yYBC5O9qGOmwKIHINDg-1; Fri, 11 Jul 2025 04:46:33 -0400
X-MC-Unique: CS0yYBC5O9qGOmwKIHINDg-1
X-Mimecast-MFC-AGG-ID: CS0yYBC5O9qGOmwKIHINDg_1752223593
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae354979e7aso149004166b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223593; x=1752828393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XbrDPX/xoa0o6T+YEo87WDthBYe7NW17DD0Ku9LRiicGQ5S7PrMaG51c2QAmrAZ9yG
 4j7AecPU4f+5rlmuJpq87HHnqnHgt36Ms27q3LqtP9VIQzi65VShL8xXSPvAPWbFkm6O
 2ig+HvOD02gMl2VnknXns50wVjf4b5WfZouDMQWEYvwzKvP/1+GgnVhSjR9z2YpLsGEC
 BoKPNKzKL9tMuQGf4ooP+ZuZtPii/Fp8uhvk6kParM27D/qKXJdMQjbdh5niZVtDLHBQ
 GnPmzDzqJeAijQgecyOg+P0gOj7KB1z8LgcsX9yo8HZff9Ux8DOh9pitwL6N0Baq/QBB
 ScWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAK0kpIoWLSsyv3ix9zbvhgnQq86Wo9n1D7TFo/AqH9yy9XmtKqKo1yk7qJp3DMVCHGEJFv9bKW3t9@nongnu.org
X-Gm-Message-State: AOJu0YwHTFzkmDtEIKjRHul924KpFeRvQkCztPvcYeL50kJrh/VWBFGt
 L7D4NB3UdUNlg3P9eXy4a6TCEsHAKWvE8qY+Lt5leECfkxeut8q74FVDViqagB7O9/CBto5i2Iw
 y1M+3X02aEz1vJWRr6B5V9GMJZOCmAV0Tn1KDf18+C/cresk/wsuE7N1Y
X-Gm-Gg: ASbGncvIga4WmroxU2feYfQVg8PegBmZipkcC4so2R3bPYALuD7r++nn3hdqSSdBKkv
 cwCXcwhp14hnfR3oRHb+Q3l6ytdwdWrAS2Jdk1IjjGKs41NBQkobtJv0agQSkLiTcGGPYLAAdAc
 qjqJDwe8IELkB5fy4A4Gxu15tuVWYu4AO4lYN5AOJCPRQzWJJ5FCQnsLwqp7xLvVxOv2WsthlGA
 YWhhF7ZZQjab1/mJArq8MVtFyjlNaCItxl3Qz6HocH7OMxwGZXAtrdHQcN0WqhmMYjwKaQfBW4o
 2W0QvB2QEUI7HxDgbEbBPR5PBQshskb973MtR4ldQeVCKodVtRS0eVAHwLE+06/C0u6fJpuA3g=
 =
X-Received: by 2002:a17:907:868e:b0:adb:2bee:53c9 with SMTP id
 a640c23a62f3a-ae6fbc12007mr260395866b.3.1752223592674; 
 Fri, 11 Jul 2025 01:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0KFU/dqqXb1I0IxKi07A77/fRBje9uSJwW8a7fboAXaECs/lbAqpmjefL7HXnVrcq84Qqog==
X-Received: by 2002:a17:907:868e:b0:adb:2bee:53c9 with SMTP id
 a640c23a62f3a-ae6fbc12007mr260393266b.3.1752223592215; 
 Fri, 11 Jul 2025 01:46:32 -0700 (PDT)
Received: from [10.35.88.123] (93-44-61-216.ip95.fastwebnet.it. [93.44.61.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e91d10sm260620066b.5.2025.07.11.01.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:46:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/tdx: Remove task->watch only when it's valid
Date: Fri, 11 Jul 2025 10:45:43 +0200
Message-ID: <20250711084543.458236-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625035505.2770580-1-xiaoyao.li@intel.com>
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

Queued, thanks.

Paolo


