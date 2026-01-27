Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CADD13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfVn-0007Db-8I; Tue, 27 Jan 2026 04:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfVk-0007BT-6O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfVi-0008ML-Dm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JlLKtgGT3vPQQZvB17jqrpM0VTt5ccCd9E5uyvEPg+Jod2rmharxlmxdy0z6Kmt3EJNXtO
 MnlIUFdCpIlXlLG56tUZXt77uAmXaApPeg/1Jb3lMEFEMS8t/ANwZbVjE5+prGmN2T/G1n
 EbqAdeK4WO0yznpXXhghC+MDJnQItZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-btYzbh6bN0Wvv4hKYa7Ynw-1; Tue, 27 Jan 2026 04:37:19 -0500
X-MC-Unique: btYzbh6bN0Wvv4hKYa7Ynw-1
X-Mimecast-MFC-AGG-ID: btYzbh6bN0Wvv4hKYa7Ynw_1769506638
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so34633165e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506638; x=1770111438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=bpnezXJvnNEMc6qGzu65hMBY7CfzkPgvs7lsZuSfIyTkH/jCKAqOTfaes3KregTUeJ
 jLz5IlusKFiKhS6+dSXSL80u3KHAMAgQTi8O792KA6Xs6FQxcyZyH74DfuswlaLIj/RP
 +YvSIDuHaSTGqXkk9Am2S3/249HWBoQxq83SVXHcDmM6I9/KV9Ed1qpIRWZKDxLQ9KE9
 xTSgpsRhvT76duB+1sme08p9UAOzBkyg8EyL6bYYNBOAmcriyYGZt5yGYsLnX0Z+PSh5
 peoo4kIjRps7/KxmHwA0FMmZpbz+IELMnUuiIC3ggEGSSZstYlvBXexaz7bGuZUz67c1
 YB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506638; x=1770111438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=uOnJQbmCKHXbAAtNlmmDdw6uC50YDyr8i43DvtseKTnwQJxd919QDa7el2QKWA5DQw
 d0PipxI8XoT5cMnoDJSNQNs25Q+gjrXS2+rp2SDvBF3MVWz1VjfJEQJkMikzYLwAyJb1
 NK6oeAkrnSYbW2dgwfPVkj9stjus4lLKRWTWEm33AKqGRrc1+MI3japPEje9KumtHfco
 DuEGnQCAfEZRH8BtlfgXc5cxOgROqjzSjLWv3Vo6NXvuIq9LMy5NMDkrA7vgt1MaVNOH
 Qqo6D6MnFYMlPTkqUIbElxFWRoGPiNz9ybUIHy9gq9A3vPA/d1YSv2RzEy0wyBhjV8Na
 gurg==
X-Gm-Message-State: AOJu0YzFu9pqOPZ1lZwy15g+JaYaGKDrpDdNMPKm1n2qThJdlorK7W/M
 pQJDTkhjLXt/8BmHK+VSka0XoR7lZNvz9qXFflKjBA6/CjrL93u8cDLA4qeIP77gqlQyrnegJrl
 OPc5bYtcjmn9WHZc4uCuqEGx9OkeBx/nXdCdLwGSbyxPFRlnXJiUDt0+m
X-Gm-Gg: AZuq6aJlxTWu4Aa3Lgp1Qur8gcDgazu5+zxlp7S+cO3DpR2pXnEHrUwmd9ctbkLzwQp
 +vyfPrICdx5Sj37NbPlm5yuFNUYzNAWoSEF2yJNGda3o7+R0qJRrdKNwo/tp2CxvueD5WjDwdno
 C40srLItu3ElrLvtQVAeqE3dJ6JDhXUwyyy07Ck5Edys/iaiX0Y5joRE6oyxXv7QUC4foGTmjmk
 fpNk9nbTETtSA2v/MqxkiCRUTTcqZ+nMPAWp5SdCK/O7PJl1MXOK5tbKUhkjXasHPX6TEQUmXFd
 6uU3qqRikOA5ET8/iGQcBtWFbfiPVAGQ7vOF9Lnj5ffAnKvewnYPJ53XG6dEmUfyE2/AuhEAgC3
 1KWJhaIgNVfdsiEAF/tJOL0GhNPdOzEt4ggkDDR8/mFrf5vCk7k5UkD5lHspdaXBhoJnAorgLRu
 WTwdzOXjGpkV38dA==
X-Received: by 2002:a05:600c:8b6b:b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-48069c92effmr13184135e9.34.1769506637889; 
 Tue, 27 Jan 2026 01:37:17 -0800 (PST)
X-Received: by 2002:a05:600c:8b6b:b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-48069c92effmr13183805e9.34.1769506637498; 
 Tue, 27 Jan 2026 01:37:17 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm49024895e9.13.2026.01.27.01.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:37:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohd Kashif Khan <kashif04x@gmail.com>
Cc: qemu-devel@nongnu.org,
	qemu-rust@nongnu.org
Subject: Re: [PATCH] rust/hpet: remove stale TODO comment
Date: Tue, 27 Jan 2026 10:37:15 +0100
Message-ID: <20260127093715.353125-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210910.28889-1-kashif04x@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


