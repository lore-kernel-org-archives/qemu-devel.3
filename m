Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D0CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slp2Y-00070U-9v; Wed, 04 Sep 2024 08:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slp2K-0006Kx-NC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slp2I-0004Mm-PY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725452577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ly40wk/kjYB2YC71PbPwsJ7sspUMBcfX4jW55+9Zxcyik6Ik1Tq8Q64eCyrs/2F5hjrFbv
 mEvL2+83pjiFPjIL7VBXp3e2xUo7CxW+kaJfvpmHlhdph3gZ+3nHOd2KB/nlj5m+Y1Xz1z
 mh2+zEbjKE9WjpddQY8O//G2AZ5nnPs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-pFJXDHxPPNyE-ictXL776Q-1; Wed, 04 Sep 2024 08:22:56 -0400
X-MC-Unique: pFJXDHxPPNyE-ictXL776Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5334acbac00so5875460e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725452575; x=1726057375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=O/d3eBL7lCR1k3B3zNMrtQhUDGAFbjt/Y59PA48BuoW/NtcAZ3PFAPI28SUzpNGr4T
 dtqkfolUPN6d9v0+t81HY5E5IDOis2I2P2g8Bsm7/8NDlmdx2xLGLFmEO6YnnS5fChKM
 7fkv08eiOimpANOfnbdK0NxPgPq+yF2FYUEt1Q8ekG8yUBjQm/FqEnb8Z2cmvDIzlrm8
 1Sw+pPbgKsHgr93d+U3lwSDLzm06GP1pAvMF8skCDywBzcf/PULVUmZTWFUh5NK1AZr1
 YftusN+E270E6HV2bMd5tPUii0OlRpb+yftoahRObTI/RDbYZNY+FuXloUE0D1wD86Rn
 CT3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4UA6VfDtF2lDE8k6Tp3cB+ciTRGFKaCrE+aXP1Vve54AEqmItJselJ2Y4jBDHoL2zTze4M/piLUWo@nongnu.org
X-Gm-Message-State: AOJu0YwWJUW8SI2PZsiAJ7o9ARU4bl1FBqZBXJCRX6Qnb/6Nd8ogWP7L
 7MEwDhfd0wnCJ26rGIOIIClUe9w0d8lUcWaMn5O40AB049qSIBbycEGsjS5Hs77xuT8HfbgQv3i
 U2T9GClEAEQDUAarp5nSv1fVwZmWS9heBno2GfHXepqU8TY7NSZMd
X-Received: by 2002:a05:6512:1394:b0:533:45dc:d2f0 with SMTP id
 2adb3069b0e04-53546b931c8mr12244908e87.46.1725452574925; 
 Wed, 04 Sep 2024 05:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Em0B4WQdVj+ndnKwa/MbfNw8FPzXnZlE20GbqZw5nEF0AYhy1vnhNsCfI1VGJOe2LODBcA==
X-Received: by 2002:a05:6512:1394:b0:533:45dc:d2f0 with SMTP id
 2adb3069b0e04-53546b931c8mr12244886e87.46.1725452574413; 
 Wed, 04 Sep 2024 05:22:54 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898922295csm798832966b.198.2024.09.04.05.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:22:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-trivial@nongnu.org, zhao1.liu@intel.com, armbru@redhat.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] kvm: replace fprintf with error_report()/printf() in
 kvm_init()
Date: Wed,  4 Sep 2024 14:22:53 +0200
Message-ID: <20240904122253.281351-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828124539.62672-1-anisinha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


