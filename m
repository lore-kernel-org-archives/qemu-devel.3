Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4078CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoQ-0004cs-2f; Wed, 24 Sep 2025 05:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoI-0004Zb-4K
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoA-0004l9-AQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hJt6IuC0vyLZr1331KBBwz4pXpM7XhSe3x8xtgsFGY=;
 b=bA3WSt/13oqw6SIib8q3bTo+SIen5MC5bZKgtdGzRkNHk/Gx0gOlMNk+Ly/2L6oPSwW08J
 zFUI5MgoKMJXc4LHIlRHp+ntNVwsAq7NZjDW8E2IDRHvGvcLUBb2wKm2OMjGzdZvS3CQEJ
 EeFxBdZ7LwdkLzlZ4toEUn+6nUJY1+0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-yWbQS6yIOzCWA7W7P8XqXg-1; Wed, 24 Sep 2025 05:29:02 -0400
X-MC-Unique: yWbQS6yIOzCWA7W7P8XqXg-1
X-Mimecast-MFC-AGG-ID: yWbQS6yIOzCWA7W7P8XqXg_1758706141
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b2ef8e0133fso214148266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706140; x=1759310940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hJt6IuC0vyLZr1331KBBwz4pXpM7XhSe3x8xtgsFGY=;
 b=jS8QSWM90+spZePC6iWyzzmgnTqxC804HCFOeTmf/LftgWvixlZTddD9uUoUX6siLy
 oUUXYkjMHapizTfcKTXTJHdgJz8Asr/6jW67eTDDjvf2XyGgetAxoACSWFP4tVl4RdEJ
 AGNcSqoRgQqo5YQosklrMaNUaC6WtEnt3Itp8eCpzL90ACy1t8J+oFbrsSNKes8tKKl2
 h0d8WehXyOYnRtAnPfXj4UCl49X7KyVVVN/B0IBeBKnHi49idJGICdDTRwTdCP7fwKWF
 +QC9J0znDJ4H6TrJD9lDgV5AMSl2qUxBmlz0gsm/VHPgCWyXla94pkwmEtwfiv99m5WY
 QaTw==
X-Gm-Message-State: AOJu0YwUBiJ9lmv/+jPLC4PFcx7QVgYCOcNVzW+dWACehdkKwCnZZNkV
 a2EhhDfBXJ+dA5AlqEgR0LtIYaSvhN0XWA7Eg08CwmjgIIL/cfWnoMwIqPbS4M95jYkGfyscu/g
 876X7VgUAfrsjho3btySNEqx7KBnNN4Hbun1Iy3JyivyWTfkYhZIY54aUZ/QWfQ7mK9Rzjgv7iL
 fk4TG6V/upHcHHwykCIESPcXJ0Zx8Jqn3EHIVgjJYo
X-Gm-Gg: ASbGnctTFrbfsUY+6L+jHVlFTAN6ZmTLmOQshxo2bn60apOLA3YSpTvcA6peazTj9HR
 2ncZviUEdXGKBc38rAZ7R1PJOxPWCPDTMQiBi09mGicIpRHTjzVzwVv4yZgKXc2ZWszAbDN4DqD
 3ngTVhTY1T2ywttIeOtetVPqaVfFfFJ+O+M66hhAxRe8NsJoKWA2i2ipVijtNazOGlWbXg5KMJe
 VwrUZucP7skV491AGIR4/IFsWp6JH+CkOZHa1Ph6ANXP19JJuuZY4JyIj5h78pMauaq9OET//k9
 3ICEmyEj1cWBobpGSYClT+ZFoLkJBr6QY2y5jnj737gm5DAHLKOptzhtioZXe1a+61B7t2EVq9a
 vsRIxaVKD9z2JzoR/jvaXKcfsiLnqXtkyKoLOLtMA80C90g==
X-Received: by 2002:a17:906:c14e:b0:b07:c714:f3ca with SMTP id
 a640c23a62f3a-b302a84f6c9mr589812966b.50.1758706139944; 
 Wed, 24 Sep 2025 02:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGRiKSUbM+jAMl5IXfzA8a/ZgIWbv3ntJ5e6m1yyWXXoz6LFLxkpFfEk0Dx/CXRehI2E8cfQ==
X-Received: by 2002:a17:906:c14e:b0:b07:c714:f3ca with SMTP id
 a640c23a62f3a-b302a84f6c9mr589810566b.50.1758706139441; 
 Wed, 24 Sep 2025 02:28:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2d5c22db22sm569500866b.68.2025.09.24.02.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:28:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 03/29] rust: vmstate: use "cast()" instead of "as"
Date: Wed, 24 Sep 2025 11:28:23 +0200
Message-ID: <20250924092850.42047-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reported by clippy, fix it.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index c05c4a1fd66..e04b19b3c9f 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -144,7 +144,7 @@ macro_rules! vmstate_of {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
+                .as_ptr().cast::<::std::os::raw::c_char>(),
             offset: ::std::mem::offset_of!($struct_name, $field_name),
             $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
-- 
2.51.0


