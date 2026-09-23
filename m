Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C914C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Q89-0006be-1i; Wed, 23 Sep 2026 12:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Q7z-0006aN-Iw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Q7x-0006s0-LE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790182043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXaMsbnZtKnLRTezxMFeOIjBg31DMuBnsSV0SPJmWCg=;
 b=DwTF6C8YHKUfXar9NzL1UbB3EHgaDJdjVWfF2eox+yB+mUQNv4PgygEp91J1l0f0qrip0b
 QF5B6wfUzteWdGi9sf2LMM+7dTHBnSHrpqLtULfNbO1fOyn+xPLk+1fjbHenBaswddCp85
 z/nUwhnoglwQGwx9+/ly3QQ91p0myAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-M_1tz0TxO664RwfSdYB_KQ-1; Wed, 23 Sep 2026 12:47:22 -0400
X-MC-Unique: M_1tz0TxO664RwfSdYB_KQ-1
X-Mimecast-MFC-AGG-ID: M_1tz0TxO664RwfSdYB_KQ_1790182041
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so16024555e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790182041; x=1790786841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iXaMsbnZtKnLRTezxMFeOIjBg31DMuBnsSV0SPJmWCg=;
 b=YIGOpHj4TumaRw5MHuCS5Zbfr0cmYlJOH92ppXpalNSWHwaf2Bqk0pkrih+rQfi2aB
 FgIkkWMXFD1ZnjjMwCSLFNT0XCsIYCCdlWa861SlcxkuWetbAHEwiNDHxUotgE2/Z5iO
 ZCbnhvfCdtabX8VznW7XkkuUBf/6q4KkqakIvrX6Wp1z/iYP7xs5DOsKnIUr5bvB2+Ax
 ETnOug3Gj1dFfhRkJb3Aro3SQ8odBfweplrZEoOXZOSyrmm2HA6rMeCsiLo2fomaYjxQ
 Re8nytKK7I4tFGI4skoPK9w7jkNAN8uSjSJ3n4rWVmKb9NkR/W+7F5IzvD43wuL9eUNU
 vMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790182041; x=1790786841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iXaMsbnZtKnLRTezxMFeOIjBg31DMuBnsSV0SPJmWCg=;
 b=Koot8zRM2HqJ93KkW2OajTMl5aPnHERvAszmtmTYvTEIzw/XelCsby5Z8unY9gF6lp
 7b0rlo3xwdjZAJ2CmM7VPUocfqLvxvHfcnPeIr9S11eYyM4kOojIFMP+EeljHaRUTeq0
 Qn75agnNVehpuM/nQ28204fm5o7OetvzuFs9F3UfqR3yzTTXjgz2iVaPBCjBbqQipks+
 pEL+8nlyFdnqAXxN/61si5n1vZUyFOkYLDRZXf3CZ1VKqRFFUYd1cY4MTR4telgmGucQ
 TRJMCBE6UXGuxrnq9RF06isW1naHtUeUC5E4fOrrXOg0YQtjHBIOh/4NDQMqzsK8zOXl
 mQPw==
X-Gm-Message-State: AFuF++kSlwzFu/X9uRg831K1h0oTFoK7KaqjvIFEZNqkyFRclK3QnPIO
 3z+EXgESQdU2MqPgcx5u4eNAj1APZzkDNeou+C6zVl5En20BADjY+tuvIu9yba3g+fWpERugXQl
 GwgFbuCD2uyCy5xuGsN9hAOyLGdpy2KR7GVHuFw4/XXSHjmZ28tCFfzB85XVFz8dC
X-Gm-Gg: AYBFou2uFCIvVXe9xgx2VlIMfcAwZ+fHIHf/hTIo37PyiBCHp6w//WPEM7EIGnG/syS
 BBRBdl7UZtusx+YmUN0f4g9UU0W9PrGOlQtK75FW5CS6EMeca700SXmAWSY2Bxn3dkodacL6MnD
 hM2aiK5BkDA/2/PjY42MK1TzFkaAGSKrXnZSOBqvnW6ZBoj8nz2NVUpVw5ILh0sXfoaSKxbVpZI
 zP3QTm2M+k8aSzRxTCsERQ1l8P12ckp4L5AgpFeTubvnSmyOGCCOwqIJWjBaBuqtcy9j866McW5
 FqzLNDV6tUceEGBYfi4OTLVXuKNFWPak+mjSGY9x9othT7gYGZpYuzyE/1hGZO18AKfcfEzmCTz
 62TJ48mufuqPu6ghn2uqquriaO+tCPonlRiLhIkuFpBzmmniPPyx1FNRYzKreOnB2CPDW2/1m5j
 riggkQ
X-Received: by 2002:a05:600c:34c1:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49fdf148205mr45899145e9.28.1790182040722; 
 Wed, 23 Sep 2026 09:47:20 -0700 (PDT)
X-Received: by 2002:a05:600c:34c1:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49fdf148205mr45898835e9.28.1790182040347; 
 Wed, 23 Sep 2026 09:47:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18af34sm84097965e9.6.2026.09.23.09.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:47:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO write
 entry
Date: Wed, 23 Sep 2026 18:46:32 +0200
Message-ID: <20260923164631.306314-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923004631.100997-1-mlevitsk@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.  I changed the code to what Philippe suggested:

            ent = &ring->coalesced_mmio[ring->first];
            if (ent->len > sizeof(ent->data)) {
                warn_report("coalesced MMIO entry has invalid len %u",
                            ent->len);
            } else {
                as = ent->pio == 1 ? &address_space_io : &address_space_memory;
                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
                                    ent->data, ent->len);
            }

Paolo


