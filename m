Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200DED2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7jB-0004gI-5l; Tue, 20 Jan 2026 04:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7j9-0004di-6p
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7j7-0001nB-ED
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768900120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8/6T8vTETlkUdAL+5i99mGQ2ZL9QF8K0Cum2d/kBl8=;
 b=Nf+Z1ZQwHOspjilKeIiPnmqyrhGr5Pw6xY34CMcgpst+BM2ZnbV+LAHUPv+l0SmBBdvhFY
 48lRbEEOWXl3OlAFxvGg75RmOzius7ufJg6Ny0wAs7cvhhXAWalxNCSvxkXKj04hmM/JsY
 3RoYoauTUmzhAEgZSndDcGM98Nz92vc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-_ashFpU7MtSTs4tckbuWxg-1; Tue, 20 Jan 2026 04:08:39 -0500
X-MC-Unique: _ashFpU7MtSTs4tckbuWxg-1
X-Mimecast-MFC-AGG-ID: _ashFpU7MtSTs4tckbuWxg_1768900118
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edfdc6c1aso41946715e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900117; cv=none;
 d=google.com; s=arc-20240605;
 b=IU/1s0IX7GcRRDZG83ls69a270+wiu0NPVDjdebrWdoECpsToD+Lcwj2BVttD0mL5h
 aZt2VtxESwGY69HXdN6oTbmxqjqf7APkeVfADb01TEfq48v3/5feKVdqCZqVvVKTq6n3
 +wQqrLGdWqFvNQxyuDlFSc7Kv7/Q6vzGe0kscDA1pNfu5ftPMMJsXQVSrNnywTuFrgUL
 ixRxBswbLUGnpnw1bislwWAUessvBlXJYXwVViRZS+hKftNbZlEYgzIJy5yKqpLS28Zm
 9joWbMg5QvyT+vMn4Ha6Vqu6aASqpnPn86gJV0hadbQnsx7Zmt5/GFC3ge39DzeRDba1
 WkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h8/6T8vTETlkUdAL+5i99mGQ2ZL9QF8K0Cum2d/kBl8=;
 fh=MZaALUsEbm9GyhpA8xVAqI/XPJCvYtKGp4V7Q8WIeqI=;
 b=Q4+IYBxjtYp+0WoXEy4FKSj2Z1pbCSCL56HkaVzStjEwDNVcBVOI0zK4d9NXBsndOw
 hlYqfx1a6GN/hw2s7D05FJb4Rg3yIcgrBMHhaAjkZBnSQ4BVVVemwHrzIWDTLVKslnbe
 LgfWbA/yepOig8xooHMUnaN6r/i86EsNTkQ0hHyxmfPsbD+b1dg6Wpi6XZrSF2qqKz+l
 1tctqeHpkHiadt0xNp8YTGn4jZc/ncgIXB+B2V8aVuhtrYL3k/C93bzsriKIFGFxqiZV
 I4mf5L8AVKTqAqvbmqLF6KC3xSqONP2FrqD1UldPGSsPfIhaj94brAJ2CfhlQv8o/NdX
 BtFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768900117; x=1769504917; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h8/6T8vTETlkUdAL+5i99mGQ2ZL9QF8K0Cum2d/kBl8=;
 b=t7Iup3h44Y5rmZYTja6j3oQeDpT+zeV9bypScScYMpcrZAi5CXLJNGFZfZuDWbz+8/
 2ofhx4sS2H97CtWQdFCCpERoPN7igJJI1cbNitagwbc/MnnEPKpzBKQB/1Jrc5WFi+t2
 1iu3G64yA88ZA68YHRZ/xmC0PNo9ZyE3LEUJYq18sQG87o0b2A3f3QqwDy1bW/dfYEMS
 OZQiP5PwPZpKk+XGKUzlg1oIqyPgUoVzKB1bfaklXT/qyq6jeegvkczDJBGuPoxPQ0n8
 Vq90yOcfAL+DOQKYqoXXc8JVcdKHLErRhZfHcqVftzx6vNJhbTGA9TQgBicH51SiHfuB
 eK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768900117; x=1769504917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8/6T8vTETlkUdAL+5i99mGQ2ZL9QF8K0Cum2d/kBl8=;
 b=vtELwRgjnEzEzsvgWBZB420rIN6W14SmyHSqck1QS5b+7P8f07RqbfeopvbRebsmHq
 7j8owgzuqJQ1Rj3T7bOQutW7/ILkGTiLBAjO+ywdmfq2AOl2DKhUO5VnOsBAb2gjBJqG
 nSxPo5cQC2wRg+YGPzMEnWIS9ZfDOXd3IUzyXuJwNCY0fbMDQU+eQL/q6S3gu9Wmy8T7
 nciWeuv9wYztACGT+VLB/ZlU1L5zo9/3YCxj6MrYtkVvHC16KHkX6ouDxIJnYQxKAzaq
 JWCU/M/pKQMb3j8DSFE5pu9ZSr9a47sNJEH/pC111HYijppUf3VBGMb9X48YoafAt6HM
 uidQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVWv5QhPCUyWqcl3+EVBPUPdidjw8aDHXGtdTNBfKelnGNnrGY2VncBf0XXBMPn0ahNskifViTj6g@nongnu.org
X-Gm-Message-State: AOJu0YyWbj0YC30Ahgx4b4jFRQ1Ipq5A18iCKAI5dsw/Vl+BV8vPlt0z
 yi1R8kuSIrutjjZFYUoGmExhBRbhLIIT7nhqc+Nq1bbMI2et+Hz+0woAXceMPmuuwMUMXGCups+
 n/GMEmV+PZ1owAjQQ2DZ4B2LnNNbvpXpatH+kOybI/In6Pxl2sJ5s77EYNnosc3s7OqTw/U6Igx
 p4ZprE4H0r1Na2zkxsBo0LkyCHA0twvNA+bOy7LAc=
X-Gm-Gg: AY/fxX77UMLlmZKLV8vSnmBpbAV28fJTmScSNqgwrBP5Byu6zBx3Rvyd1X2BGAdOtHr
 AJ/W3Oz5z8y8DXIhfM6Ll/OGJ/87oaXre2aQTBPE5NsZvs3OPMvBvF+czUfSsZ5PprKyZkCAfar
 tJCvI9b3fsS+Lcmk9Gt7kXJL1xDAc0VGopfGh2T29nU8dmiwjJkzq1Cyg4hITlvYaS1ck/A7SKP
 d5j7mt8jcKwtHdsaHJBTsQBIhMwlLa01Vw4KXdY9sPmSdFJoJZVYnml
X-Received: by 2002:a05:600c:4683:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-48036439ce0mr74110255e9.8.1768900117645; 
 Tue, 20 Jan 2026 01:08:37 -0800 (PST)
X-Received: by 2002:a05:600c:4683:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-48036439ce0mr74109795e9.8.1768900117234; Tue, 20 Jan 2026
 01:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20260109123519.28703-1-farosas@suse.de>
 <20260109123519.28703-3-farosas@suse.de>
 <CAE8KmOydo3r7x1AMWyO3hYEqrN5+XxHuz0y9OYNJc4nPMWq2DA@mail.gmail.com>
 <e9a55c88-9442-4462-9d7d-21b1d0196401@redhat.com>
In-Reply-To: <e9a55c88-9442-4462-9d7d-21b1d0196401@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 14:38:20 +0530
X-Gm-Features: AZwV_Qh3ekNBq9MzwgXa5JZLmP_XaZ7i5WPtx-df3jEFNEfe-N7Fj9FNgI44NA8
Message-ID: <CAE8KmOxq4gtohXYNf--+9SNERT63-Ew9yHLVDxuWtg8StZsErQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests/functional: Add a OS level migration test
 for pseries
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com, 
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, 20 Jan 2026 at 13:56, Thomas Huth <thuth@redhat.com> wrote:
> skipTest() aborts the test immediately, the remaining code after this
> statement is not executed anymore. (I think it internally raises an
> exception that is caught by the unittest code to mark the test as skipped,
> but you might better ask a Python wizard if you want to know the gory
> details. See
> https://docs.python.org/3/library/unittest.html#unittest-skipping for example)

* I see, got it. Thank you for the link.
---
  - Prasad


