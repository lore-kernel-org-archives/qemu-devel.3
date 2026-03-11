Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B494112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M2a-0001Jy-2V; Wed, 11 Mar 2026 12:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M0r-0000Pk-9i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M0n-0003YF-VM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773244930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=R8rTiEYfPHkELCAbb0F/gMRNsmLn7RUJvFEKt2caIC7+/XsKUceHl7m8uY3pTgx8t78+4L
 z4IBmZrwtJfy9peUGj+gFcgXRrsC6wP5atBNdpnj0abxlpW3zWdN3HcG0ZiUXz/lS1CuO/
 k9KZ0N/k6ZEmoTUMNtV3btw19wz8Njc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-cJ2wBjU8PD21Cn76kQK8ZQ-1; Wed, 11 Mar 2026 12:02:08 -0400
X-MC-Unique: cJ2wBjU8PD21Cn76kQK8ZQ-1
X-Mimecast-MFC-AGG-ID: cJ2wBjU8PD21Cn76kQK8ZQ_1773244927
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4852cf0318dso51074485e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773244926; x=1773849726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JIaDd5/G+H1EqoIcfnlwUy2gbMYOndNlZ31LMifkb32999pQTUHEn53hyUc0kz5rTC
 aZlnddV93KUipaMdcuznlzDwbl/MEHhGlTtvZbvfOi5b17sho5NhcSXb6rMHZ3JZHNgw
 TARmqa6RNviNOOFWsT01TAwJVYT2dqOf1V14U2VSNtIMAmBOyhDviGOcfOFdTvZO3nV6
 0yiR0fNB/hkA5WPOR6tHKal3/41Gkjj22mBviXaahWh0/cbyQbvSQdv+XZJgEQFslakS
 ETNSXmTisWhK5ZRmz2ghxmunv+E5+LvNvUT3fmvHIN0E48YWfQEIr1EGeTuF3qhHvw2+
 Pm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773244926; x=1773849726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eFMOuVp8G1vhRfSP2bC32nlF3I5yb3sgPL4+gCpIGrResTPPXdd7NUreMT3jqoVcih
 R5SVLJ9lnMbkoqRG5+RQ4NqGeerIHvBWsfs5JWhMeZHqdekN1lIi9KQ7cETQYxFMxvte
 fGegX7SzCe3dyeHfowAWqAUL9x5aypeSnsMJCaanPsgB8ndQQiytdZxdnKCRr+By2SmO
 i3gfRohub+aj5DhLJs46ef8S4/OJfO+7KIRol6wHMOD3hAegEzOs7FcPWrd5ao+GjEqI
 fjW3uLPUIkzPlJgu8zSfPZYO3hGT3c7pAwGvGH93Q7xNV0m3vlrQu/M9rCsObVSnM9nG
 9dyA==
X-Gm-Message-State: AOJu0YxGAjPF7XZ1cxUfOIyA9NC6UXL3rZgpljubd0cxHLmHJ+iuVbEb
 UglMKJSc+fvQh1N7waMjbB07Djm0hcxBkSQLKWsV2mvt2SUJEV5Ym5WX+ANtD2Ohnu9bWqKBBr0
 1RbrrJeat621BWv6S/Ejn3k/zVZo4GSBIFDaHcMm+589iwGSsHImoX3QUGTD2D049
X-Gm-Gg: ATEYQzzeGQQasMGebljSa+pxoYGQmmpth9eYfpWE+0szv+vJRmvxiU3S92aavCNIeMM
 5AeivYR6ejNSefatK0hp7oS+KvTQ4sFUD59RSAzArEbAbGE4xOu10OLxbC4doIHj+4eYetm6ARn
 Vv5ZhyCXyCHZI2W+0dvj+YcFb2zK6RaN1/Xb38urXqx+DLnatupqnht0djyWi71EZwbbmUNBpAJ
 M9Git3fOMiNwLBVgDIHFzIH0PK790igrUGkgDdN+zY1ziRjNhQlSIPMWEL2lXE8TJjy5ySiZBsW
 VYv1alXiuG5MNxrTs+flU7JUv+uSMVv/ri4Ps0zTAZgjNimOP8S9h5B7YpNFDkNmsC/Spxwbaq/
 MZcLZQGqpFy3KAkgXcevZrYxBm9uHexOjyPeYkcSxy85saFEFOgEKWrUfE90kHUSKjs2djz0AC/
 Ar3TCbyHWfUlx3Y96clLiedvA2HXo=
X-Received: by 2002:a05:600c:1f87:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-4854b0a5802mr51457175e9.3.1773244925469; 
 Wed, 11 Mar 2026 09:02:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1f87:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-4854b0a5802mr51456575e9.3.1773244924909; 
 Wed, 11 Mar 2026 09:02:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a1a4444sm36652075e9.0.2026.03.11.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:02:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] i386/cpu: CPUID & CPU model cleanup and CWF cache
 model
Date: Wed, 11 Mar 2026 17:02:03 +0100
Message-ID: <20260311160203.551108-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310140819.1563084-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


