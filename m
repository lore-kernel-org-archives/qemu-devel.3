Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ECEE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlZi-000079-Nu; Thu, 12 Dec 2024 10:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlZh-00006z-UD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlZg-0000Wd-9j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734019079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ChNQwghGMmOxvOhnVcBeMl7HUhKJG+JaWggEymmf3/tVwgZx+/bTIORRTo1CsUHHji4zDW
 USmR3eVKuBehvilJ1eTvm6HyK09nIMm27jDSA3Bqq091rCCfKBNoffdAPmcMn4Rd5egc8F
 4mTTK5P65qBrhSsMMssfDQfJdf9K3ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-rGZyz1QINLyYVqjF6tK1YQ-1; Thu, 12 Dec 2024 10:57:58 -0500
X-MC-Unique: rGZyz1QINLyYVqjF6tK1YQ-1
X-Mimecast-MFC-AGG-ID: rGZyz1QINLyYVqjF6tK1YQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so371719f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019077; x=1734623877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=k8I8D1B02kaz2pLgSNXbj3McBb1xosFIBXwx5TJEacswX6lsyhqtwF1v0/oz5niNOR
 ff0bNfwqPj6PdZk13GueKlg1wUQX30bV9BnH/zgQRGloskZqdtN3AoruFDhj51M+K+es
 nNInnPeTmV8c3Xmo4JbWXxFnRo6WupEE4kTyTVMNYMdkXUSa34EamGRV8+nH2Li/wVAQ
 8r8rTByD9rzWMWCkRPEIpU4wmovnRULS+inFwMW666KW6Bczdh5mMuahYuF3++FXwIhg
 PecRtL1RWuxWGqnQUMn59fNoPlAPNWPDei9ZusYG8pN1ebbULQQaM333Uqr3NS9svrG0
 KEmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKae2oNObz9B98swEnpftRC2wax+Z31qWlj0WWtqoZy67DocAToqB0HJJzdCFcZYwxofjg/hhT70l6@nongnu.org
X-Gm-Message-State: AOJu0Yw3NcBF/bDInwOSDx1uPfGBlnGgkdbVfVEhyR72NZja95KdWcLZ
 l7EkjWw3a45byMxeFG2Y5TRFBH8e1aHbsqU5OjYgiKqZ5V/cfiX+djJTKMGZgvBHQlS7ALp3GmC
 EaXnkDqUp0W8b6e9rsX2TCv9hlR2jwFpdVT5d4uV8RnwoHe5xRI9I
X-Gm-Gg: ASbGncsjQtaKyuhhaKMRYjOpW34w6ZrtEXL076r4HrLqNvKHebpgX0TK3+pe7fweX19
 vv7IIoBAtW/DqfN0I3+fMrMmieHDd31LB/kBgWNp4F74b2DOqGGO2JDBaKNn44GTetjBLfvJhSo
 Q3VHAIC86clKSpkF45KmwtSp28XdudWDeH/lCN3E/zOUnRM1V3EEJLozHb4kT1ePHPOhr0qsvfJ
 V1vnLi3AEYL9ilEr0/SIwGIqcCThYE/cAyUQ+C1KPUOYaPk6eXbSxZiUBN8
X-Received: by 2002:a05:6000:4013:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-3864cea4553mr6574616f8f.35.1734019077117; 
 Thu, 12 Dec 2024 07:57:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR83C5MMeDF8fnzp4KAbDZ9IwQ9YCimFBYLAP7JHpn0+TXjU2U2saynfWppJ2/nv7QP+Warw==
X-Received: by 2002:a05:6000:4013:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-3864cea4553mr6574608f8f.35.1734019076832; 
 Thu, 12 Dec 2024 07:57:56 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dee1sm4340989f8f.102.2024.12.12.07.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:57:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: Reset TSCs of parked vCPUs too on VM reset
Date: Thu, 12 Dec 2024 16:57:55 +0100
Message-ID: <20241212155755.524767-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


