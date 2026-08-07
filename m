Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFD8C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKcD-0002BK-3B; Fri, 07 Aug 2026 09:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKc9-00027K-9C
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsKc7-0007lM-38
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786109273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T68Rkh08EFUtm9VJ4cfpqm0+kdoCLjRKhrUlecRqaT6MTSb99Uz30VLvZ7utTdqBuIARBE
 RzkKWgpahvqBjXmHyemxs5pvgE7Sb7eXZ6F/Pho6KcWvM00cYRJXuz8V8RDQuk7+lx/x0r
 nUy6urLVEG9RB2p0C9EfF8KFHkMAfcI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-jmDMZh3XNlOHAlYplPvJuw-1; Fri, 07 Aug 2026 09:27:42 -0400
X-MC-Unique: jmDMZh3XNlOHAlYplPvJuw-1
X-Mimecast-MFC-AGG-ID: jmDMZh3XNlOHAlYplPvJuw_1786109261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so28650855e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786109261; x=1786714061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OKxyVZBNXuqoLDKKkU3srNRrokW2sxaAAKvv6PrTLwXhKwyV77wNxsWXcjH4GQrPJk
 rs697h1DsTthEMe+/NgNkklumVob3lcgCzxfKr1x6B/QA/9ONO4Ds+6Q+pqniwXvvOKm
 gygP9r4tZAQWaUEmZ2io2n0G1x3NV/2vjolbzJxqJWytdc4JMj4zwcJyS8ngiDIy4AGb
 qnjetDMyoxRhEDH9h372cTK7fsPkPJJs/9ofhz/r+IywRzA3pD50byZQ8y7X9DPPq5Ha
 g2y2yRnkTGiTYue9xEV/22uhWltkhN48CSRek9nxx3AOi2nvHpAw8SvUq/Z9M+e4wDqI
 OtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786109261; x=1786714061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Viz6y17m4AWlym7ce+stauEYGFGhIT402n892UW/dwFhIBsX12lm3aiJvF+Maum0A5
 QwNXhOZaGu6oDwPNpGvR7IJhCDcgbd5rcVj6Lt0fuqmNuvQXFLvL4YVKnn9IFvTicFUN
 EJOzP+0uPsYcHVlqH2l+mE8yOTAg3h+2PeFYMKJoVFm7P4iOQwoU9qzvE2tBa9higPkZ
 5I/vwWxJkVFTV0r5CjSuOD/mm4bdX9+iyu0xHvlaJsarou5SWOD6PcdLJsYeGKu7dk7M
 OO1rkxUe063UuxfJKL1eSBQkIs8Rv1n89ugD3zRFl9PuIcn3KbWDD2BWVJLWzY/PoVWJ
 bPNw==
X-Gm-Message-State: AOJu0Yx0EEbwRqwvJ3InL/tTVaRacBrEb5HgtmrkGEIHQisKRt6mh01I
 YVjjlgd/h/c9UqBgG8pnjmxy/CeVnDsb9zG6X1EV01W8ZErJn1z5zoPb8iSJYKqOVJP/ZcG9t2p
 EsNhBsCWsujKwejrpBIgCBMKYLCmJT51z2NjbbS+8+v+tpwRtM0raM6oP+O2UuAAp
X-Gm-Gg: AR+sD110AO5XQEBTU3Vdz14Gsg7sVHAeVlJ5qtfZASCceuMI5HPZ5kkrqDrx4CX1bQO
 xrwr4oYGAIvyfXZZ/j0hgk1QG5GukxLgfO9JciUdwNMiQmiFJiQyxSfFvuU/b+sP7Z0XzWyg8je
 xLvbb1bhq3IDWQb6nOyb0bxjBq2tXWc4KE91KaIVHkcsoXwMZxtZyOwPQxqiqZ3LSlCcFnZNC2/
 tTc1detfeLJkm0nugh7vge6l2HnpTY10ZTDTJK5wSlyWNB6JNRSWl1ZyfnGSKjB/NhBui8BDJoR
 gBWfFgtdb6aDUxeBIaGdMUn8KtZlHdyDE9rF0yQKw8cBJFkc4wKxQicmwMtJigcWAQKhyg5BDSp
 XL1rjqhpsVAM6plcyAmCLvyoJfRersKWR/Iv/cLAMM2n2TNYg9NBWGxn1YdMhqfJPakGfgtrB3t
 EqQ/4=
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4994e71c87bmr246043645e9.7.1786109261233; 
 Fri, 07 Aug 2026 06:27:41 -0700 (PDT)
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4994e71c87bmr246043035e9.7.1786109260701; 
 Fri, 07 Aug 2026 06:27:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c777sm64016475e9.2.2026.08.07.06.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:27:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/i386: allow transition to virtual-8086 mode only
 if CPL == 0 and CPU is not in long mode
Date: Fri,  7 Aug 2026 15:27:28 +0200
Message-ID: <20260807132728.2611910-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260622082119.11903-1-apolivodaa433@gmail.com>
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


