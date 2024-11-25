Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907BDD58D73
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdFb-00016c-Nb; Mon, 25 Nov 2024 12:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdFW-000167-E7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdFU-0001p2-Cb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xdk69IssmzBUXlrlgN0651gfuNqPbjiHIelP6q5j4Dg=;
 b=JOnrob8GfupJWY54My4eu8/Nda2FVPsWRNbbZbSIKz4l5vz+JNUiqdv+xDWCQGadMvvJum
 s+OyoTu/ewG2kNeOK+cAa/nk85EvBqaiPRz2EFzmAv/8toeay06zCxdBL7SW6BGDc0p3tm
 PayxojSbUNGTMFdFITi5BMjy8OxpN4g=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-JJAibHvwM1azedKdcGjT5g-1; Mon, 25 Nov 2024 12:51:44 -0500
X-MC-Unique: JJAibHvwM1azedKdcGjT5g-1
X-Mimecast-MFC-AGG-ID: JJAibHvwM1azedKdcGjT5g
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841843a9970so151529039f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557103; x=1733161903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xdk69IssmzBUXlrlgN0651gfuNqPbjiHIelP6q5j4Dg=;
 b=Ov+hLXJJq39Q8+s44QV7921hvG7Vzc0fIQuZtyKyJQwsyJI7RiRJhIGanOGXqhbUoT
 Mhbc7hfCzLW9wAhnlXQIhxXRl7PZaTDCM0CR5nvJlw3eHRTs1l/50+U5vt5yn9wwZSct
 wndcOWcTsJiL7d90o6HERrd4V2cCh3FK95khUliU52fbBX76Uzx0iVzZ1m6FcyCC2zEk
 +cuBDlgt25N8KDKsstOq9n5GqFPK8qaAKxdVrGzjmXef/CjQkCAr0bc6qxgcvuuENRiI
 iFnbgHHkxtRP1SeGLqZzHtJXC7ORSoE/bU3WL8Tq/yNuKCSwtxuf6jDBvJXUBmQxeZSG
 jn5A==
X-Gm-Message-State: AOJu0Yy2elVTla2Tvdt5ZSYy/opjpoDFI/qlOd9uJp3yHmaRpf/rbA+4
 dgjVCHGn3aTxYNcSJZAqIhY8zuFfkVgVtW1kTSbEL8uE1DbHDymKmfbM636Gk1z/gE2cjMpQr6h
 2ew94AIJ63RqMJB9DUYjGo87xqqjijwU+CEUDIINFDUNEsoSLtvvdTpnQ0hbR
X-Gm-Gg: ASbGncsX+5HgKPa2wcu32op9fLE97NOvdjGRP/orqtFJTXw2CU8KfKT8yyFm6IOvD2N
 jMbxsjV2q3D7jhClakSO+IMxqoCBJSx0T7JwryZ3QWBvtzIkNHG1tE6NkW7qG8EAh+KF8gEgPqi
 c73dzUVmE5YM0mpLZitqJzW5PCOZKrI7zQs8P47waLx6m5clyQgk6SwYz3TJb9nhVAEczDBaIdK
 V74joBWVqIeC01y/NTB5bS/Wl0F9J09o5U8CfVRpeeW8QJFh6zCxCErthNZW2H4A0U55QJ7RQTL
 ByUNOeTFCj8=
X-Received: by 2002:a05:6602:14d5:b0:83a:d646:9c0a with SMTP id
 ca18e2360f4ac-83ecdd16358mr1092140439f.11.1732557103628; 
 Mon, 25 Nov 2024 09:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9GwTdKC601JXo76tg9AIGAcESlBRfo1yhMkTKQlpyMYNQJ4yXnJF+1QgjpiskrONYT5CoUw==
X-Received: by 2002:a05:6602:14d5:b0:83a:d646:9c0a with SMTP id
 ca18e2360f4ac-83ecdd16358mr1092138639f.11.1732557103344; 
 Mon, 25 Nov 2024 09:51:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84199ef66f1sm55187939f.19.2024.11.25.09.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:51:42 -0800 (PST)
Date: Mon, 25 Nov 2024 12:51:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 14/22] tests/qtest/migration: Split postcopy tests
Message-ID: <Z0S5LDuo2ksvA_L2@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 13, 2024 at 04:46:22PM -0300, Fabiano Rosas wrote:
> Split the next group of tests from migration-test.c, the postcopy
> tests. This is another well-defined group of tests and postcopy is a
> unique enough feature that it deserves it's own file.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


