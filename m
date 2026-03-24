Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CCAFEC0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55Py-0005bW-IS; Tue, 24 Mar 2026 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55Pm-0005Yu-M2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55Pl-0004tW-Ax
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774372776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tpxjjy+NS6Tx7ZPu1864F69zPx3oQ3WRX4EAHigzJM=;
 b=hwgTJajhiwteE5/QYOyjShs0NKHQZmnhRAVqqfCTWwMWVzRYIEhdr6zFj4WBsetbkulraR
 W6avA/nnoxn7B2G8k/c1LvD/6Ha247LmYt6/imRwZlFIkEIUDvTnqGrUkAjtnqBwjGlKya
 nVnPfkwcp/IUVbPcqbLlzgj8T1Ub5SU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-1SRL_2kQNmGHlzf7_dbzBA-1; Tue, 24 Mar 2026 13:19:35 -0400
X-MC-Unique: 1SRL_2kQNmGHlzf7_dbzBA-1
X-Mimecast-MFC-AGG-ID: 1SRL_2kQNmGHlzf7_dbzBA_1774372774
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48534941525so52618315e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774372774; x=1774977574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tpxjjy+NS6Tx7ZPu1864F69zPx3oQ3WRX4EAHigzJM=;
 b=quUeXBLszWApNbr79R4kDdRtoOBx81Osr3jRmB9nLRbLcK2de9AK5HDpX2XVZuFMlS
 gd4VwbRL1f6UfSGqz+mJQKQdESKKKzt+evp5FX+ykwDKCg3f2MERo8Nvjw3gx0h2kfXw
 FZm2+mPk9GnHKdeL0IkKJloihyEhuAUSq1chSf9JQENb/Hqbe8sY4ru3pn3kZCNLztbd
 X+0XbBhjrZBPaIBqDsuSQxekB1/ij9eMgPH8B1cSvrh9aAAlRveV9dNNvjXJ/0QMDKoo
 u1Yyev9c9xz70++TshfAntwyAE/w2weXNsM1w/F/jT+3ItgqJ4VHi9Z/cbyhnIoL39tw
 gEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774372774; x=1774977574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8tpxjjy+NS6Tx7ZPu1864F69zPx3oQ3WRX4EAHigzJM=;
 b=HtKCpHtEAYQtl+zdOt0Frw1bTN/ExD90wJssRZBMknFrZikQT6Li2sdvMjL16ruoVp
 tjDAoVuH73+jQiGVH1/AB+VF7a0F5PpVTBSfJVqsnZWhjw8/7JWklNeASsZW3XxxX9Ty
 KUAAsYZtbh6iNOiNWWumdqH+/6ae2FD8kLGrZ5AsqUzdMRBtYIyYFv8SwqLIFTMzazFA
 6BbHt2WTA7WIRPAQJeA3GRu6Aa65Nsw5jCtGJ0iX3J1O0ur52b13hUeXaPxojs6CiFG+
 SIQE+3//yHXeZO80qk6ZaakDviQPcDriIKNSeCZ2jfHtggGlqyOptMuVKfKalzw/wTPt
 p8Jg==
X-Gm-Message-State: AOJu0Yx9XnjiQ6hizht0IV4GuuvvJ564istziIMmTh98Om7Ht+5LzPbl
 nfX19LPkiD6dB50qdgchSWHYDkVlGQOmo87Z1fLKlHTjCEc+gr54Ks90cDAyMwz5wWxqu2cfp8F
 IjvuT0qEa17QOSrMTrsemN5iKRkeFE/J9gJ6/aZ0TdSkBKvqCCrZnSn35
X-Gm-Gg: ATEYQzwwzq3PgViVeL8SNiVLn3leEc/xZq/dPILTbMKhJG5keJqOxveNcnv3UmXOnLc
 fdIwyKtJCR0Nqc+MaPwHZf6a08/LQAaTE5QI+pHO6Pwn5H8VpoC2plXm1qxy2O9DtBJmbgRnSTc
 o6OHAhk7r7P6vxhe5lzQAVIRK10y7MgsyofMrSPAfG4P+il6Y+TrhulHvACDtgbbYM1qy3uAWuA
 9p3G8FnH7QVUYj56M1uVFXtZjfQCOblYB3Pm2ZD+uKFlz9TMFCfbBj+bc1vQnbDkSBgm/JguEhi
 k8BqOcSQ619s/ReP3G4RQB7nfFKNaH/c3I9Xdcs4UY6bxNCRSDKtoNu3sGXgbC5RwHT7/Q+QcK4
 oR5IKAr7hAnKmaJPqxCRJdrMAcZLvXJ2MDflKbdjs6ungD3ttzCVfytkN+Tw1QLQ8lJ3wmq7jrA
 YvPM+MRTvndnbXUAx9M7jfPlYk
X-Received: by 2002:a05:600c:4f48:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48715fbfc42mr9174165e9.7.1774372773761; 
 Tue, 24 Mar 2026 10:19:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4f48:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48715fbfc42mr9173795e9.7.1774372773336; 
 Tue, 24 Mar 2026 10:19:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c35sm39824765f8f.22.2026.03.24.10.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:19:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: Re: [PATCH v3 00/12] whpx: i386: Windows 10 and performance fixes
Date: Tue, 24 Mar 2026 18:19:01 +0100
Message-ID: <20260324171900.794207-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued, thanks.  Perhaps you can make target/i386/emulate remember
the registers it has already queried, and cache them in to env?

Paolo


