Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AC8C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKSz-0003ql-QD; Fri, 07 Aug 2026 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKSw-0003mA-1T
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKSt-0005dT-B4
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786108691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=O6lHtJ4VaQixpl3LFXSgRJ5E3uEwlgFm03EsOIATGTRFkj5/Y1CoPstdXYbeawDU+Xm8+U
 M2fGTMvLdzEnMC6ApBn+dN/yIG2+s5PodNpFPk+yIIYC/10O8IYcMoIsUAqrUNvVEzCs71
 XwQestPAxUhNoN9No4+tO8dAhnc381M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-xQHzikCHMNO9E-ZhjIZMOw-1; Fri, 07 Aug 2026 09:18:00 -0400
X-MC-Unique: xQHzikCHMNO9E-ZhjIZMOw-1
X-Mimecast-MFC-AGG-ID: xQHzikCHMNO9E-ZhjIZMOw_1786108679
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f83416551so2928084f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786108679; x=1786713479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=oZ2G76bZHU/iqenU0e2hS8VuEwX00gpPmzzcIdvPiAcGe6AzPy5UidpjW3d5PqWQec
 it5aR+3dO0Rf5ZAPReT2rt58IM3LSCr+5LjKopJ9OH7ijZCueHIkKNMzjnV3I/Dbw8q2
 yNMNhwf1CcXQPFAcg0/nnaPpInu2Bq9FNB6KYxPDjqwzbzQ0HuNERGknMlJJxlhXxOvV
 BocBlKa1P7K8Qvn3BmbTQyY6ZIXbtilZm3OhoC+BIYWt5UsE9Q4vWOyN+m97Rono0jFr
 QS5wMYJkqp74Y/hADMfOgaB00/hOlPwwRurrEil9NavkMMUAEjNBk6o08YJqCwRlwrl9
 DWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108679; x=1786713479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=imA0RlBeHvKsywPbtsZgW+GPyamoAbbf5ibJspULi6BMnduPXOSptshpMzlSxUBl1Q
 Bzs5pbe/O4digTWvuVrpMOTJhTGwRd+VKZILsNDSweHz/4NBLNOWLPJhQR/xiZLhXfoY
 JFjZRJhjvz0yAnzK5Y1TJjTrjEhSiMSWl2q9NOgqb4L9EKesyCioVci2qnqEBTMWJuyD
 3hllHKIHjauyCxcvv9xdY7BASrXeF7M4mTSIUPQsgnyrA/whPXBMrWsZ2PUaTaPQXlM+
 n2pflbbVZDlOElrmelQjSK900lce9f3xZCdgdUz2n84w1wJ+vaT9iymp7XtRZTeC4WIP
 SjBQ==
X-Gm-Message-State: AOJu0YwUnblbgkU37MWFvU//AXZ7AR4BIdgcs2V60saKfAXXT74duyn/
 W7dc9marQ1qnHi15jpeRWH/u0Jde5gUoOLu7cPBUaWWPxiWlMG9UnAHf7RBsIEZzi8XmvuCWl43
 zEGVmZelWA5TvxjIiOvSDvX83/fq3me4tdiSNY7hJQhGEiGDYtXKyudgE
X-Gm-Gg: AR+sD13JCOmjyZCe6LprX7FM2v0MMwwItgkOTHtRpuRrXDIqP0W5QRr6tAVrlFwByhJ
 pLF2AwLMn7cEIbO8m5jvynLIMOtpf3HcN/ImZ8StXhEGIV7dx+d1BlTznuSafKn1dxTbx/vDmfg
 pp4Xm0jArcht4dDnod3qNYSNXxbOsYTn3lkcdoqnhbwy4lKBfBOqtvpcd2tYqbaKfHUxGar9+hY
 EeyZkfPj4ujU88hxu7hEkHAztyPsFd+GDPVi2NbWyYurryU9GSTAF/sfcWPqxbVJ7r608g8JhBM
 xmVM3gCchJvMCpkAH35Mc+p4UyTnhTljzRWk1dKyFC1IU4yWnvqrNi3AIJxKjCfqz87xkQplgv8
 EB+1KafDw9eqCnmSOZq1mGWs/26EEuglr3txZ/I1swt4o1EGx57AAX8uKVbXHGrRkGBFmbZNq+a
 NOj4k=
X-Received: by 2002:a05:600c:3b04:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-49959e016f2mr123702185e9.3.1786108679394; 
 Fri, 07 Aug 2026 06:17:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-49959e016f2mr123701515e9.3.1786108679067; 
 Fri, 07 Aug 2026 06:17:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f93acsm6217608f8f.29.2026.08.07.06.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:17:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] target/i386: Skip supervisor in xsave decompaction
Date: Fri,  7 Aug 2026 15:17:55 +0200
Message-ID: <20260807131756.2608255-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702124746.450228-1-magnuskulke@linux.microsoft.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

Queued, thanks.

Paolo


