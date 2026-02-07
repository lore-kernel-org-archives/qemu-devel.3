Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C7DEE0AE4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voids-0002Wn-Fy; Sat, 07 Feb 2026 08:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voidp-0002WV-Bj
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voidn-00037F-Li
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770471986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=W8KH7Uwq9QIUguQKf4WPuza9ioojhZgN9gmnEJ9nufWtw9oOlyjAHOAuCm73qQzcwJ3Pfe
 VSMFB2H8GrLxIpSASgpGbmrivO7OFBo1l/aoAgQccUcdqtv6iU2bLC+c1U0HpsINRiFlsH
 OMMjA59s8tbC2zKJLg/cvJmJmVwrGyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-DLI18KAMO_2D6f7IMLL_Ow-1; Sat, 07 Feb 2026 08:46:25 -0500
X-MC-Unique: DLI18KAMO_2D6f7IMLL_Ow-1
X-Mimecast-MFC-AGG-ID: DLI18KAMO_2D6f7IMLL_Ow_1770471984
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so36190615e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770471984; x=1771076784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KMVbvOP0pfYPRjyqc3N3K1Oasg0BTrpMWRdHIPVDTRRHXUG3XcmrZhCRSgo2exZk8p
 iCwoKCrKnnUOaJKbAmv9bJl5/Ogct/xZ0g6smZE0YqkZ6UWD6rPSOL7ELowO3u0t+mEv
 7mVdBxqOijLWRRoNbjSKo1fknUbhNETiJ1Kr7DAv6XQP3STgGKm2dFewryjm9L1A/+Uy
 nJYQN1u72y49WIKbJSCWjT6WxtxqSHh8jqoNM3sTHinBxfcD6u+e97Acw8ZC7wYOLfXG
 MrUYXaJWdLwf58c92kDSxPZ9vKSER+07Z2ENjjoBgYRd/sZyutqZLg1ELThZ+v5Ou0Mi
 KODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770471984; x=1771076784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=c4/JJT2GhNv1gB/7qjCVuaCwJEfnNREps3qtJw1JF7am0+s4TYAXUM5ci54zCgJ6HM
 viggJrT8yX5LSqgenI12FTwL5WKLCvmlhs19Xe0DjA7bsRbXODAnaSNuUEbrJT8p+xoF
 CPg3LgMnO86IUrpIu1XzoAhoy9cL+Rw4Ek/ke2rX9IiJ2GeblJxVAl3D9ZnIeC5Rg6du
 dySQ+hAFauSykBxmXfhAEvgsLN4x3bqBXuBDtl4h+63ryzOxdcxAk4LIfR4vrNiIXKIs
 60+/PhRM3g9mteCLIF2D86E7a+oD0+skisjBtrmuXvc/zr2UsE/h6kNMBZDPVsVOU3Tg
 2xjw==
X-Gm-Message-State: AOJu0Yz5JmcmrOUDGsH05kJY/81BhIYxgiuqYiRsg98oFrjX43jpDRxo
 L9CyV3+KEjCW+dSbY6ROxJbDrrwqVwHo69c4q0hnRDuNn3+n2ylnZasO4vHSNlUBtL5wgH1gd4+
 Dupfol7QO4oKxMuXj8mhU6CHwtfeIfZykVVJyD/bNd/vmBNbGDogeNRRp
X-Gm-Gg: AZuq6aLGZ4Epy9IYhvZNQXlmAEHFm8y47Y6b7QWfW4A01t+1F2rptVux09m/zGvbWX4
 LBGxruJw5ec6rsy0pwS5gr1lAyPT0+7AM6ZCIAdvSmpPSS11R5lPljzeE6Zd5cXY9vSY0OHn70i
 AAAPhmEtQ3rjU3n97VojD5IEhem465o4jW7Eh6xiydyY4nPaHSC/rUeR1mRhFgem36lB1k5+1Mx
 akWbwjZFybKkgoMR7i4igQP5TCm7zCl5Ian2p6RqwBKArIR4puEVouiHVOMSQrgeg3W0aVUauBS
 If+aYmKDPZxw9e1qlnA+LJe7YNY4mZRS0aADm+I7gP2FhttRZ2VYcrpSXLx098+QjG73GUQ1WaC
 L6J0MZtp0B3ajiZ+YczrGAzYF9EFqZd5yrgmPNmSdI7RM8tPoXVFAo/14Ap6UoJ/yiGmrhKgND/
 K4VS+pidb8SJ3k5RL2kqOmW+KYcBlnWCc6dh9/7pzJ3mlpXXvZ2E93sw==
X-Received: by 2002:a05:600c:19c7:b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-4832021c5cemr74399175e9.22.1770471984169; 
 Sat, 07 Feb 2026 05:46:24 -0800 (PST)
X-Received: by 2002:a05:600c:19c7:b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-4832021c5cemr74398915e9.22.1770471983703; 
 Sat, 07 Feb 2026 05:46:23 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e245sm207101655e9.8.2026.02.07.05.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 05:46:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 zhao1.liu@intel.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, zide.chen@intel.com
Subject: Re: [PATCH v9 0/5] target/i386/kvm/pmu: PMU Enhancement,
 Bugfix and Cleanup
Date: Sat,  7 Feb 2026 14:46:19 +0100
Message-ID: <20260207134620.638214-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109075508.113097-1-dongli.zhang@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Queued, thanks.

Paolo


