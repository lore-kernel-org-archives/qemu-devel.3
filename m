Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKch-0003UG-6l; Fri, 07 Aug 2026 09:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKcf-0003Qy-13
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKcd-0007ue-O7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786109307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ciKh1fJnC3KJ3e3ZJNqCiapIqYcAczG73nCjJQzAKmW+AlqUmNxcRgk5uJDnO28Ihbj2UA
 dCBow3u+fg6ZyD53NcVE0Pk18CxJvvinRQR8HEgPplDaZqpmDBGS7fzsFh3gtiRp8CNxmg
 TUof/3yCSnYZlkTpSfGXP4Lq2sFgsW0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-7PGg5kDgNK-vT2Ijc8sp1w-1; Fri, 07 Aug 2026 09:28:15 -0400
X-MC-Unique: 7PGg5kDgNK-vT2Ijc8sp1w-1
X-Mimecast-MFC-AGG-ID: 7PGg5kDgNK-vT2Ijc8sp1w_1786109294
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so31980865e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786109294; x=1786714094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aVNiAWkcjytTfRmSvzx4XI532EfZ+zexroZbRlExhk9Ky4o8NuaW9vrE4J+bqFefbC
 2gC5sTd6pV1368NTB8phvk8NwiTScZ5nmeCfciJTw7+lVIhMqljbbR891yZJ3ro8M24q
 fvmSdXQOfYFaXkHS5TrIbvWTENoec8KxW77okoLXlLbynajIlM1xllybuJ0G6SGExrre
 kN/Yr40YuefkEC7xuNBvyfJ4LYHeAFhmkKkOFJ8bk5znr0wvJ+413Itc+WF8+G6Vqnv1
 sKs8zQJm3D9UES473D9tHAxknLFja9J6dTJIzHxD4oV2lFoIToThdnppRoDB4cHSjN5a
 cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786109294; x=1786714094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nCiEI+74HJewQVGSCTOPO5/xtXjo8UGPwRDabT+6aUidzTUFOzMJmIh7k6xh912jqT
 mx+ugLUdBU+HSUG5XcPUneOwY7UMY4hqanqBWKJ+iapn6yS/WWnNjAaCKr3SGTyvcpQw
 f48ywLArmhBbbDB2OZCu9KI7XZ1DvTisohdyWbfF9sgh5+0OuWjVSbaDlgAdzmVtTneL
 vw7GaEE5ztv3rw9Kxoe8WNfP0AbtkDnvo6aUiK+cB6KqJERWqFxJl1uCE925N88R+SES
 /buL3vRqiI5n0iUmqh/euJph5XLj7LTPeywVHguymN6dfQaCJbIC41pGweglouacYJgt
 +1yw==
X-Gm-Message-State: AOJu0YwaiDOHsPtRCGYGKO4+8aKOkjqcyQoMHkQ3y1gb+5gaz++OXWBV
 W1Cl+MhCrL5/ZScD8WIl+LzwkAzXZbn+3x/CCi1CmsXh5y/lPHDKzuSYBA7Od9pmVxncoIlOK0t
 yBCxLXrGelbpb7t6T03ynp6mKCTvVVB7XQJdZCN9DD/1do4kQfzUAL1NeOZV+OOOy
X-Gm-Gg: AR+sD10tzXi0wWkkzm0iV9PtLkWty+f9/Urso2KRheBPPj8kwu3ohsNyJSCJxs+6r5e
 oq7vFL4wmWRrjvNWhbG4TiVFl6/dvCyLEO9NlvjaSCBboG3UpIBQyB9bYjCvyoi4Ew9wazGNGEb
 45Ic3Kquj7369J04JRniTJ9arxdfxMhPg3QJjnyFc2TOuQFJ23bFpjh3ZnDqeKikfs6lvImgKDW
 0DXlRLM1DpV/iPHyZeLaFADRqA3JyYzlQFzfKtTFebzXA5uVsoUh6t08xk1ftB1IaU5qjBchNcU
 tAP4UYqs81EfGr3gKo4dS3y7DP0YMYUqaYjoHfXLLYqwSybVPnQ/uQKWdW6VKstUrjltPfEc0dY
 Gr9Bjx1u1TAx3eWheq7swtmCMcbjZUIuiD/dW1dWjavvpsneSHRYfrBt90bqsV03FVFMJ4ctySY
 3mVWM=
X-Received: by 2002:a05:600c:5251:b0:499:5b04:6920 with SMTP id
 5b1f17b1804b1-4995b04695bmr81534475e9.16.1786109294563; 
 Fri, 07 Aug 2026 06:28:14 -0700 (PDT)
X-Received: by 2002:a05:600c:5251:b0:499:5b04:6920 with SMTP id
 5b1f17b1804b1-4995b04695bmr81534025e9.16.1786109294180; 
 Fri, 07 Aug 2026 06:28:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499541b86f5sm147356735e9.0.2026.08.07.06.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:28:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/i386: decode opcode extensions group 3 /1 as TEST
Date: Fri,  7 Aug 2026 15:28:12 +0200
Message-ID: <20260807132812.2612270-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260621032524.1138213-1-apolivodaa433@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


