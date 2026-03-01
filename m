Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A412CFD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwhee-00028s-BJ; Sun, 01 Mar 2026 09:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwheS-00028e-UT
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwheR-0001Zs-FN
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772374804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xf+i6VnU/geFmKrB2Mix/SJDoN+M/zzhgdh01+oSyX8=;
 b=VhUbF5Fsttrnaiua0Dr6hs+7uTT5UfKsw0JWSyvxk2Ox/cmg+s2S21G+NLpBJ89It5nVLG
 k5deW6uohHYX58pyn96wInQ/027U2qDJa85BXh2N3R6XG7pRrMtZvyZ3zqu3q+jnv4AeY/
 uBZWixntgITeIIOpeoQ+LUWw8xJ57fc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-IFKg-6_oOVmEYlgFAZwidw-1; Sun, 01 Mar 2026 09:20:03 -0500
X-MC-Unique: IFKg-6_oOVmEYlgFAZwidw-1
X-Mimecast-MFC-AGG-ID: IFKg-6_oOVmEYlgFAZwidw_1772374802
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so35907595e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772374802; x=1772979602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xf+i6VnU/geFmKrB2Mix/SJDoN+M/zzhgdh01+oSyX8=;
 b=eK70Y6zL0kOT+gM+McVxQgW/IITaWgozOiRDSflmTTKdwMRCQbMkxBFkYurb+mNMjz
 H9f9D2e8oT604+xcBDKAHkBu5CwMWZEGdvIUV0chESsuffmvbA1aNy2TwWvG5A7PDkCO
 zxSWDmfHNSbB65F79TSYV59W1wmbIWeq8clQkehesru/QBJR1PhMdZ496bN4fjgZV7bM
 UxNQmHD2f1Myu5RpNhishm69QiIMF7/gQu9FRNLCx0AEi3gjvA0g7IUuWOCZITnyjwQN
 vmRtuVdaQDI1n7QQZp42bbF4fDjYbwQxQwWHYXQlVAzx5873Ou4jw7bZGF1vKiDrPQKT
 eNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772374802; x=1772979602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xf+i6VnU/geFmKrB2Mix/SJDoN+M/zzhgdh01+oSyX8=;
 b=qL8Yna5c+HdbENTYKsN283CZ54yCGhMcfXgaHlqAN4gar9y45G6BDkGGtsjhmvxr8p
 me5Joy9I880zkpp41RMGEGHLXDJ1JPygeDwNk4JbcouE9aHOLA0GB/paKYEOrmBUPjm4
 JqPi3wPvkgVDExPXX6yZEIiab5JTcVKUsA3g6pKazqrU3IZq/US9r81XyfA5cTNYeOye
 ++SIGIRu5stYWOL/8l7ZrAc7ufTSvX5dqN0Pf+4tAcuPAgeh5w8Q6dbawr2L2vNHtfgb
 p0owaVEKHQlnRZB2tOWup8P2xm+iCtlyRL8YJGeGmQutXEmGzyTMuWAj1/rwsNnG84gp
 BPkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF0Qvg53UdOGhup57g4fonoG50WDcmkO+Fb78Udtkv6f2Of7fDoZB3LzDnH37pKY8glrCZaUzm1tYh@nongnu.org
X-Gm-Message-State: AOJu0YwXYTGrp1gDzjRa5Eu7FClG8UE6x6/PVyepDSzr8GaBLGPi8tFi
 fQflIOhHMYBObUGpQvkcUw+fpJP4AWtLUVubjixwPeZHMgZqoleJEj+aNYMdHhMN3TZWmb6pizx
 YCd553TGQS1bcNZLQA22FUSRjIRhDaKk/4h5CbvpmcxcRbLr0gvx4vwq2
X-Gm-Gg: ATEYQzwq9X5nP6f35QvNA8GFTydzkfEAAAKppzX5LOjnbeynZCNqq8MS+7MvVadjoOL
 7/RBZDcdI6BdDyIy0wDwN10TZbZaa9UokWUqiqlHKsoTVOnndS1+MsEf1glZWxFcPxIQhImoqjY
 ogWRpOJc+TQ3UHcGRKQOTLSkZLiK+JZLmG4uwnA5OI4QV6pbCpGnl+2ksPuqDEMVqyf7odbOpEy
 SoiPOhDyC+Oe20hspX8rJhKom1MavmX65Sj7l7OwyXw8AjiFmfixNWOIrTSXmmp9hVnGO1Irkcs
 6F55jt9xuOUEqUsg30jdIHZcRdL3mX8FSxSWxltdxXOe4H1cEVT+1uFiz6/FtBM65c3QU36lwlM
 g/5WYPgVQvv8xIkvHWL7haBn2dTuslFTeGfmmXzOCn+UbkdpO36oAPJaRkMijBKFFltKYeGIqLQ
 8sj8q/Suo7CWLo6aU9hWFWzPDar5I=
X-Received: by 2002:a05:600c:4591:b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-483c9bf0b3cmr144276345e9.22.1772374802220; 
 Sun, 01 Mar 2026 06:20:02 -0800 (PST)
X-Received: by 2002:a05:600c:4591:b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-483c9bf0b3cmr144275995e9.22.1772374801771; 
 Sun, 01 Mar 2026 06:20:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776dfsm197542595e9.1.2026.03.01.06.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:20:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 0/5] target/i386: introduce ITS_NO to several models
Date: Sun,  1 Mar 2026 15:19:34 +0100
Message-ID: <20260301141933.448426-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Queued, thanks.  In the meanwhile the last patch had to be changed to
introduce ClearwaterForest-v3, so I have adjusted that.

Paolo


