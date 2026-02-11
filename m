Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3201EB5979
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4yh-0001Ag-Mr; Wed, 11 Feb 2026 02:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vq4yf-0001AG-1N
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vq4yc-0001j8-L5
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770796173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Szk0iBjs12Z5mTkJvcTxC6C7WGffT/RNgC6eC5iqdJ4eN7j5r/2RMmX5+jhOWoC/nbIHO4
 NTrgqtoFne1ScoUwZtb55MDaztYDBBfwiNvxc0LBWQ6EK2rsHPAQAVODGQuqZSbbCxuu8a
 nP/rIPqBcuqIcARRYlY3f95Eh2+AnYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-FDg5cPqINEGF_9YbT3mDqw-1; Wed, 11 Feb 2026 02:49:32 -0500
X-MC-Unique: FDg5cPqINEGF_9YbT3mDqw-1
X-Mimecast-MFC-AGG-ID: FDg5cPqINEGF_9YbT3mDqw_1770796171
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so18372485e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 23:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770796171; x=1771400971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=pLYPy7bfZVY40mTMwKoCmj7OLqUBf901+3ylpMW1tBfzvPkxK9/vexeipDF53eai9+
 w+EReXWwDoG1zraWyakxhsm+orP0K3zdoEJFLtL4qhZ1aIWnkk1CT+SBtoo9seNuGJVk
 aZwklAfUk9r1T4R/St+oh3Kmf27QiDl52aCXJZq8WFX6n5Olig7hjFaWW7+eRnGwT1vn
 LpwE8xIgBp+t70G8sLgZJC/kFJ+Nlb4QJD+LP6XZHU/UmfRLvPeU9IlmxbkHPl18jiFf
 fmb5TCn0y2kflYyk34DkXGUMZSCZp9XF9BPoq0LieuU/zVF+IXY4dxs6sShy5swhCxxa
 QYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770796171; x=1771400971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VusBBx+nh208b1fX5TW3yay83Aet4IAmmfdJ/7Y5XUEEpScZk9JVOdb3nYg3dFLp0p
 KhBgrN36nkab9z1zjJxcosVs0oSNK8dU9aVHKGWWtMrWTOhIwIYixc/iLBQn7nrCoyBC
 +f24oLg/thpmn29Y0/r4xQmGCBTmcs3WOrd+QgWBNspaKikbJ6XxnqGVWsk5RFZj+3ki
 xRRZDWayU2eQDr/TJWMpGJ5jvQ3F5FA01UWNgce9z6q60k07HoLMjRETqnuoCD8m0JIr
 OGyvEMhZnu2BJaZgLuH11lAMlKI3+m/XKJQIhjso8lUkUeLVjufPpWjDiEntVWMRubzd
 /LZQ==
X-Gm-Message-State: AOJu0Yx3QV9DoVWlnlQmSrzwu23jPVDhEpNgNUuy6ciefNUt7PN2uLZ5
 wpHJ4w7A8JRhtaHokyocNHccOU2zc0iSXoAYFYejMB9ItvWRBkRVWuDopgTJrC8Hpn+DRO8ACad
 U/W685GZCfApjptx0sK5ay+9HkYwBELJv2LR6RtM7/gj+nzWdxSoHIfub
X-Gm-Gg: AZuq6aKuTRW1Es0jxOZ9G7XcWUAjDwtdCsrVbKlJjsJSXPbbP66FeJpFiV4DbDWEnz2
 li26i+aLYyFQ7mBHtKqSr6nm/XwRHC7q37K8F8EbsWc/HUIgJYoPAXddDCg40yed55wRlW0nrSR
 T+peZy9vxnqm5umZAberAsKspVvbOA/aASMlQKIOULPKSN0ZHueAMUpEYNf6+sQu8WJxhAmUZeh
 Dqoy9zfvwqlph859zw8zgqvhPr/DSUTM+1D7QaMVmDma33ySnZ1FwQhXg9q6cKnuT8OSG8m6bW5
 wZHbJwGExsD+Th9+ubhOjK3iq3GCwYHNi5jxOvAwj9/hLe73weW46sLTqlV3UWMRMrQG6Rh6N8m
 NJNwybhKJNosrE1TFNfQ7+hFRENPq8KvKUV9mxN3pbi1lgoCcdf5uEnsSwM9K3AxS5llTA2UXWK
 KFH18584yEJVNVBmLq/gspB3NwHg==
X-Received: by 2002:a05:600d:6447:20b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-4832020dfadmr174072205e9.9.1770796170714; 
 Tue, 10 Feb 2026 23:49:30 -0800 (PST)
X-Received: by 2002:a05:600d:6447:20b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-4832020dfadmr174072025e9.9.1770796170350; 
 Tue, 10 Feb 2026 23:49:30 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd20519sm40750005e9.15.2026.02.10.23.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 23:49:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>
Subject: Re: [PATCH 0/7] whpx: x86 updates (2026-02)
Date: Wed, 11 Feb 2026 08:49:26 +0100
Message-ID: <20260211074926.1411965-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
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

Paolo


