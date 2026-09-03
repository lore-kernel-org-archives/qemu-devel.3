Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BBEC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x268X-0001WK-7E; Thu, 03 Sep 2026 08:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x268V-0001W0-JI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x268U-0004hA-7J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788436901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXqFPv/1Hnwdr8FTCK5PSt6eeDnIFyQrX3Ywr0JKRW8=;
 b=JQPCzN4oIxZ8ttu4bVti7eAM/9E3fC9duU/QLdgPMhOD/30z+p8kB9gLZBsinlZYmTnKk3
 BCuljY/Ga/8R4xDvnVVoKV6nwQfZ6to4Kql/7f9NpL5n1finPqZb5FJepoEBS1zom9QA3q
 UeiyHVG0RLOEhklXHyTm50a6M+0BmiA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-bMr20tSCN0uluYehO_ReUQ-1; Thu, 03 Sep 2026 08:01:39 -0400
X-MC-Unique: bMr20tSCN0uluYehO_ReUQ-1
X-Mimecast-MFC-AGG-ID: bMr20tSCN0uluYehO_ReUQ_1788436898
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso1615299f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788436898; x=1789041698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MXqFPv/1Hnwdr8FTCK5PSt6eeDnIFyQrX3Ywr0JKRW8=;
 b=enLio+unaJEEohaO0A6nPnDl6u/rR8zG4nl97umQP8a/Fgos5L9UfLQZnZcResXmTX
 iQVvh2dZnl7P0ggHUhEZyKLzpStvQdM+sEiWXo0v5rKiwhXkzQ35Y1d1E0CbObBYaPGP
 dr1635SStBSEN0baiuvqBRrS4Q+jmkHExmw76uO4ogDTjVYkC+BVpJjiFEkWY3f0ctZ0
 3PK9kWBdkDWSltAPt/vi7CEm0Mdh6xbI70s2Mp3qliCIGC6+gq/p03DkLh7aiGCIHIte
 acBP78S7BxTN0XkfGusINlU4+iTM4mWFobF/feYZ25721x79biVyXJLCL6nMtTTNZWQw
 UgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788436898; x=1789041698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MXqFPv/1Hnwdr8FTCK5PSt6eeDnIFyQrX3Ywr0JKRW8=;
 b=b3DJIhljuDk984YAuKWzLbZXNdy+ZKt+14w+7r5aNb2IQMiBwt39pEWDJhTkZ2LpvL
 lMYRysGDIEGSvnXJsCqS/Gj19k6j8fLqcmX+T5Gkd/xpIgf5+x7rdiH5QkP/OYu6ZJAx
 cgVNIGAB007A6rZmzv3lts5EzFc1OlYAd8Pgpw+XeL5Rkow7a1ta2kf9m3dmtszcb2F1
 G2jKvCwLXvhbTlEe/95zh1Q+NA3suY1WglZ5iDJOc60FpQEjk9MPkMTl1KJUG7FOWxkm
 JWgZVmMFi9U2IcHbcmr+pzmwhsch9fThs0ldpGpeed+XPMxQtYCaYTVM0F2y5FzRuY5s
 AwVg==
X-Gm-Message-State: AFuF++mY3EWNmxvZvLeIQ9D0B41W9q3D5vZyzCTStVugydHPfDZvBm9Q
 YBwm7Rk7QEThI8mHMlghr4ua+onZAUevgb3cOzuwMslvmdo7ai8naVbKhDoS0bqmArcjFfxGZw+
 bCi4v8+281+ZIFrDxbtdRVx6dDiehGvS7UEtxpbXp4OxE7n3ZKuT/VCVK
X-Gm-Gg: AYBFou3Ey9T3JOm3m4IsHT3zFXXKvnSQsR9Axcx6i1maf0oqbWzzFVbSIS2PFnsiM64
 rW9uysR1EvrSSNTSVLZG4Jv4vcGQKibdLCFjvAsR6GI78kRcpcIQisD9ae72GNI0L3VxWyPHCbP
 WBesRrmXBdwFukgW9cPj7tc5hNPa5BvpSRbA2TQId7IXJu09sgJMbx5kTvBTAMiGV9yhxtN0kIu
 4aV9LFz3uJBWtnrnZOrFana7g17CFMaHpKJzipOdupJSKtxO443z6j23oRXvgQzVEIdzUC62nrW
 V9nbBhjaC8pSzt0TMv4vGC+u6bkTytK0+4g/ngv9tLRbAOj+XLOsCoOXW/qhZBnepRQKVJWuQgC
 9XGYxKdSvD474jY54Z+lQNzj4yT8Z13yWhZlNJCUJGwieVTeRPBFYVnVUWjFYninY4EqB8Ru4/q
 JfuU4=
X-Received: by 2002:a05:600c:524f:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49ce584c87bmr181506345e9.15.1788436898382; 
 Thu, 03 Sep 2026 05:01:38 -0700 (PDT)
X-Received: by 2002:a05:600c:524f:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49ce584c87bmr181505255e9.15.1788436897878; 
 Thu, 03 Sep 2026 05:01:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d9db2sm68673935e9.8.2026.09.03.05.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:01:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	mst@redhat.com,
	chao.liu@processmission.com
Subject: Re: [PATCH] scripts/checkpatch: warn on duplicate trailers and
 self-review
Date: Thu,  3 Sep 2026 14:01:14 +0200
Message-ID: <20260903120113.806380-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161157.2112984-1-marcandre.lureau@redhat.com>
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

Queued, thanks.

Technically, a duplicate Signed-off-by makes some sense, but it's still worth
warning about it.

Paolo


