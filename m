Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2A8C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEsK-0003uD-Mg; Mon, 14 Jul 2025 04:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubEW5-0002tm-It
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubEW3-0007HD-Gy
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752481581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMxGua/tdPam4dVIC0u6fe3G2ruRsSuMutFTgIE0JGc=;
 b=YsetZE3HhZ8ZxoV2ruMucsKK00ue5ycZ+bZJeupuHIF0adiqJrCdy8MtSKyG2rDYeY+1YV
 L0YSrpxsCCy6lSg1hgusYTca6iZJrdlhtSAsOnMMlnZyDqBT47lL59QuYqwUf4RD5k0xYo
 9tk5ooLpxYozQWNnVyXCkdCpgyzPyqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-pqsKIEW7PrCnZ5bhA0eulQ-1; Mon, 14 Jul 2025 04:26:19 -0400
X-MC-Unique: pqsKIEW7PrCnZ5bhA0eulQ-1
X-Mimecast-MFC-AGG-ID: pqsKIEW7PrCnZ5bhA0eulQ_1752481578
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2612802f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 01:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752481578; x=1753086378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMxGua/tdPam4dVIC0u6fe3G2ruRsSuMutFTgIE0JGc=;
 b=R4QjrMZZ6qTkOQsZRkh1zfReW0wG6RltexHPdDEoWh4+EkgJtjKt2J8AsnWBfNkVZ3
 rPaIdNHz7egyzk9v683H+GefE2yrUmOeKRJYyeYgOdGmxCJRKOWfY3pUe+T67TQL++iR
 C/UGxlZMMizM9v8DRrCc8JK1ER9P6l9MMPf1VBGkKE3+SeVu9nZWkWGzHyv18MTqwRfS
 gzKLW+DTkPf1maOEKUjqxsYrGlhfTg5lye/mowVIeCfhfPDJtYNHf84ZdJbf3IHOgKlh
 UEfYlVxAvshUP/B2kOTjlGQyR5JmXY6TS49vbUL0kcyvo235E4DqOIkS/LDqb5AM8KhD
 MFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU28D0k3ZBvVV+QgkvXsfisB23XHdv+TRdZogy+yvuG2OXQlArVJASIXL9OE16rh/XV+vXhTL3BP2cT@nongnu.org
X-Gm-Message-State: AOJu0YwIprzcxkVXBRxCqvPD37LgmdkSGX/OcXxGleM/CmoGxrvGhCT0
 N/XKFMxGksgR6w+bOgaPQkDZv6vhB+nOfOjWHLTiU12Dp4TUSzg5X6XxGle0MVITq4eBPqoGjw3
 Xf9/3PNiJOL62ypX7VebQ8RnOqfdidZj4XkAf4rmcWEAe0mAOdceGNqiG
X-Gm-Gg: ASbGnctesxpHeDlWq7YRs2RRmacDsOWMbsajZZy+0whrD/pdQujwbl4yn8ffD/EYjtZ
 hjuCj5uf2WmxNkmKDDOGYdTaFNRM2mCPwAtNDd9CsQ8SUI7fumCKvOtJcJsbxeorw1RAmrDuXLW
 wVZ4dfyyd8b077EyGYniC9nlGTolXVP/X0000Q2ZKFhlFlRwnhQa5R7jYCt62UiftJ7GRPTThQb
 KtqmlGwPamWsf0ViUrER+7g8AOuWmPr5qsCrXD9RuIS2iDLDtskRoGtkNi9DgiWEzuLTziqkxxP
 /bIJf6Eq+asDLdwA2B2unkvIOgM8jQfTxscL5719pD4=
X-Received: by 2002:a05:6000:2dc5:b0:3b5:e6c0:1678 with SMTP id
 ffacd0b85a97d-3b5f2e33913mr9941898f8f.45.1752481578408; 
 Mon, 14 Jul 2025 01:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvS5jSpWdaT6QIemGIecyk5N9boFsvcgjNcXPNlv3TK/+sG0Stafv95jdy2f9MnlfGG5lUoA==
X-Received: by 2002:a05:6000:2dc5:b0:3b5:e6c0:1678 with SMTP id
 ffacd0b85a97d-3b5f2e33913mr9941875f8f.45.1752481577993; 
 Mon, 14 Jul 2025 01:26:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9349sm11599295f8f.45.2025.07.14.01.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 01:26:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/7] i386/cpu: Clean Up Reserved CPUID Leaves &
 Topology Overflow Fix
Date: Mon, 14 Jul 2025 10:25:42 +0200
Message-ID: <20250714082541.101813-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Applied except for patch 3 (which has conflicts), thanks.

Paolo


