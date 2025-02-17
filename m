Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06395C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1OR-0004l9-OP; Mon, 17 Feb 2025 08:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk1OP-0004kw-An
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk1OM-00030Z-DD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739799753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LddHf3qjHvqYC70n6K/VBxPXp4g6D7+S54hGvsghhpidCAmx/rkOVDE3+oK0U8ogDWpnv8
 5Lh/q+Wt4+gpZMpVX2RolSJV5J/9raEPbyPKTdn9KjiN8h5utvEGB1yQpTzGDpGVg/Vhbn
 I+kVBc8SCKaqCIMwTH37yEfMo49/uQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-e4X1SjDJPtCXK8QsESO_QQ-1; Mon, 17 Feb 2025 08:42:32 -0500
X-MC-Unique: e4X1SjDJPtCXK8QsESO_QQ-1
X-Mimecast-MFC-AGG-ID: e4X1SjDJPtCXK8QsESO_QQ_1739799751
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so27232375e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739799751; x=1740404551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fRNqrJ503P1PNMPnZHN8EjC7iOXCTTJCzzXrAn4px12lw7NpD3yO4SOFgheog5hD2i
 rHC1G+XnloTv+Ew+iLybks61e56qd43fcuLimPi2BN/b5b/cH4gCJfwP0hKIbG67WohS
 RjSa21Z3w6pVVlCTnYWUUd+FZzQY2Obd13UJB67sJeLbKObnaT6X8BKNB4SA7ljzSCfL
 fVMtKP8aDUbi11BxWJgEAOlZiH+odah1K3nItkFCzt1TTDDwGg6o22MCF4sv7kkS/ii4
 uVHx5Z9e2n9ZoMrhw8dGFZjtgG6+ar4McuEsCsXu6dwETKeS0tr+To1NdCe0FTxGCXz7
 rNVA==
X-Gm-Message-State: AOJu0Yz6SX6IvTjBi6SDYgO+hxsDjCW3J0yMzS6K2rTxSkjmBdW/9tki
 er0s5ga76cW7tygCVb0uOAu/Mmxla160CIdhJydmUE/y2JEJ+xoz9jiRnpemKpxs3J2jlh7e6KC
 DDz8gfiILmcAjvBym+l+6kSigfqD83M5tczQMyWn1tGA6LZhlMLAM
X-Gm-Gg: ASbGncvfYvixPXLQfYqTHgfnnKDgc1An+rBChrbKdECQjds81VPvP8nuI7SXdTeJWg+
 Ofdu1C+wIvgV38ofnb6293hC22nTHlsvKwdk5udpfB3vzKCk91D1cXCdPyIvsnW1iFbiqYipWBy
 ofbbA8Gbu+/o3hJ/mqODDhOHUS7eTwRLDqUJcH+JyNjWFT13xohWqMFwamLyd4VFuYaH0WFezTD
 S83+ese6a9jmhz91zW9y0pdzQvUnl6TVZp1MyJ/yywSVg52rVXWi+PqYeZRmmBxpP4aCKNL7z5f
 XAeofL3Bpcw=
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f33c20aa7mr8427747f8f.18.1739799751018; 
 Mon, 17 Feb 2025 05:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqtKm4hQXBcDDcCrIonBnyHpvLvCcbSOuyS3XlUuqhwbDVl7QZXjaOWaVnloMPb7HtRWMlwg==
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f33c20aa7mr8427725f8f.18.1739799750742; 
 Mon, 17 Feb 2025 05:42:30 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4118sm12622148f8f.18.2025.02.17.05.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 05:42:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] stub: Remove monitor-fd.c
Date: Mon, 17 Feb 2025 14:42:28 +0100
Message-ID: <20250217134228.410747-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217104900.230122-1-iii@linux.ibm.com>
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


