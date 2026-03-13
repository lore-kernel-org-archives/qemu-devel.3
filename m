Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C946106FD7F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ueQ-0002YO-Ci; Fri, 13 Mar 2026 01:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0ueN-0002YB-LI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0ueK-0006sK-TW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773378082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oTS9gyqw1P/Y7Jy0eWO30dzXkPhi7gAB8XI4qDo8y9g=;
 b=NtvWHIjZYcMZ0Q61erAKLwysGSoZW20S5WPhzPwZliAhmM47uiyduHP+e4pneJLKtsVJP8
 4w9z7DvKGU9R0RgQ80GC+QggyuSrGU4OPmsqmes0KsECFV7KZLZLWm3/oYtwphv01RNVme
 mVds2GoJOANXEKbF4BcjPVEqcINlGe4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6FVTrJvHMgq-RUYD8pW38A-1; Fri, 13 Mar 2026 01:01:21 -0400
X-MC-Unique: 6FVTrJvHMgq-RUYD8pW38A-1
X-Mimecast-MFC-AGG-ID: 6FVTrJvHMgq-RUYD8pW38A_1773378080
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso13248665e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773378080; cv=none;
 d=google.com; s=arc-20240605;
 b=INmzpH+0svgBQqejg2yC8fnhSsWOUDksVip1fbu+Qds1SA4Nw27OFqwUqgA1dBTRyy
 CozHobC2S2PXpCj0/oIPBiZyeOdGIxwdbeIFJ+FsY9MljqQuqlaA+0LAiqPi9z36ThxP
 FyCtQMILBu3oiLI2gMVCPJ6ztCxnyv97B69EAKR5I8XpySw1zUnGZLAyh0EHXkSgH6OO
 fzkVc97Wiv8Ih2PS1qYLBzviPHZTmnmy1gX+uCHI7W3zAOjJFm7S2SeJxhCr95DWVnJz
 Nhvpz1DZGlBafaLInF0LjITETCKUQC60+eXZFbGgDaAVpOpe5PKjqqsiB8CZqeDGzduH
 RW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oTS9gyqw1P/Y7Jy0eWO30dzXkPhi7gAB8XI4qDo8y9g=;
 fh=0RnV74n38CvrzpnKyRmF2uSdp691/S7P69fJ6CBe+7g=;
 b=liCWQda261QaXmTntEoupb7PdnbiOjwaPTpfMtLyC+d5zDqvCnGr1kLQeW1hU3Z4+J
 NN8321tx4TwfzkMXqp4i/O3X/GHGv2fK4qBFBHMlsHUolXFUZA5bv9r/GSs9wy/6aWPc
 Ftsc/58FwqDxW3uweQ9ryOD7h+DE3LUvqnNF+oNpgC4y4L9CmldA43GoOkqmcFtmNe00
 gZDqyiK+q0T1/lTVLO5hSD7oVjNqkZ2PdY3a3Lt7k5KTQrZ+DMz6cChaQ0KLZTj0kvxZ
 uCqtWKGU16UK/eCEoKt0TcLEkta6bk1oAN2TnUHbj7Rr2rE4CwjOaBus1InuOrzyooKS
 bulw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773378080; x=1773982880; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oTS9gyqw1P/Y7Jy0eWO30dzXkPhi7gAB8XI4qDo8y9g=;
 b=T+jFIlHfChNX1rKp+U9OAaV1X5XcMX43apx0xL6eH4MKHp0DNnOvJCI03MlD7McsJB
 2dx/ei6la1QchACJYntgh8VJCIxvEBg3F6lRDglILjzFVPgR7E6RhkhtQqkDPr0jTVIh
 FJ3jJLx4e8QrDYvI2KZ8am4ZSRXNgVxtpHcTrVQqtJug220Nh5HGm7IKhxpwyPl9f99M
 UfC+v/nBpSBFfB7PWgW/emhWvZnlYYnidpGksMWbAvkeGoL9KNmfKbeLKqDW3b6rGTV/
 F9prxuAjThTE84bMe2SmtZ6MjjBMjdH6uv6mQ+RqFcLB0gPCwvlGk81Ly+2jeAmqZduO
 4shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773378080; x=1773982880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTS9gyqw1P/Y7Jy0eWO30dzXkPhi7gAB8XI4qDo8y9g=;
 b=b/QxnFeppNR9jnEeqj7ZMkcVA6parqFrt2zMNUHiiaGNhNWqvGrYYofrSgpjOHV9sZ
 q4Ol/s88jg42GLjrrcpoqgq0WN3+tEbdFGFdJP1X7FvN5s/s7gjoLArV8KXQIGFbHRv/
 1LAdMTwieJFrq4AIltrEiA277rNmkmYz2bCDOuH8thXT0SE4IlmboZzsT/5XPvS2HbWx
 gjSb25aYXOLFCwhkB+YnLgm0hP3Cgu0yDeIsFKZmth7bki8MidES4iK5pp3nbkmbmU44
 GDgnKwmPW4DyvBtHrinhxEU609hW1fj7eW01chQ6QJGgCRGITNF03iE/uBvdSQlscKxV
 NrEw==
X-Gm-Message-State: AOJu0YweMTvEHv57RrDzj79U8XvL90Tb+naNE3xcuDeoHm9RVozOpWWo
 ZZooxH5usnqp8bszWwGHCgeF8tWG36fw9i0Xw5gmXgq9lPBCP6vMwFEJ9hBFy7C8KE2F60nAFSn
 KbjsM5RvWdBt9DmkLe3HVtiW3E8FJW/+gUNyVwjhi7B+Qvdt6a9EQHW1kzJdrTCuRIMlGr2fRvT
 51VqJUGB0ipV3qLiUh+8bVQlNMA8um7RU=
X-Gm-Gg: ATEYQzyXikE0YuHj7OBcV1/Z3fXhpmMxBa/T5lQWNgu6d32mWlJ8MfpY82t5VAeisHP
 I0vcWrrJF+Ndlvms1VH/XjH+z5vmU92VKpZx0o31i8gD/iC8ACXsT1DnvRxnEdeFYMvMfSZjb0F
 RncrKqKOZ0EHbp1eQT/OFd9CVkQ8ScrwWg6aXh+75hjEzMSpd1A5sbEu3PrnLkexUBC7AHpMUcm
 idCM4X4FVu8Rk/Ls3WUxZWU4Fn5BxHAstCSQhgP916l4v2KVZvgus+sCV+bvH3dhqHd
X-Received: by 2002:a05:600c:1f8b:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-485566d2fb9mr29700465e9.8.1773378079537; 
 Thu, 12 Mar 2026 22:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8b:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-485566d2fb9mr29700115e9.8.1773378079142; Thu, 12 Mar 2026
 22:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260311213418.16951-1-farosas@suse.de>
 <20260311213418.16951-6-farosas@suse.de>
 <CAE8KmOzM3Pi=AhxMGPeM7u2KzkaHXsexNNZX5k_317wzmwt5xA@mail.gmail.com>
 <87cy19yx8x.fsf@suse.de>
In-Reply-To: <87cy19yx8x.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 13 Mar 2026 10:31:01 +0530
X-Gm-Features: AaiRm53VABqSpDwpbHu8y9L1DKO6lrVCXkBSZVS3z92Z7T6N9ZlQXIWU9fCbrFM
Message-ID: <CAE8KmOx4wUVLQcg-UezGa-+aFJ+nXx12Q_hY1+8cSimGjR40jA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tests/qtest/migration: Force exit-on-error=false
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 12 Mar 2026 at 19:18, Fabiano Rosas <farosas@suse.de> wrote:
> Do you mean prior to the patch? The point here is to list tests that
> might break in the future due to this change (in case it's buggy). They
> don't all work similarly regarding the flags, but they all "expect
> failure" in some way.

* Yes, I was looking at the current upstream source, without this
patch. Earlier we said that 'MIG_TEST_FAIL_DEST_QUIT_ERR' was used in
2-3 qtests, of which we changed 2 in the last version, so it made
sense to remove it and use 'MIG_TEST_FAIL' instead.  This commit
message lists quite a few qtests as affected, which is not readily
clear. The thinking sounds reasonable nonetheless.

> Users of -incoming uri that also expect failure need to start using
> -incoming "defer" because the former will trigger qmp_migrate_incoming
> via QEMU itself at vl.c where we can't set exit-on-error. The test needs
> to invoke migrate_incoming_qmp with the uri in this case.
>
> Note that dbus-vmstate-test is currently disabled. It doesn't even
> compile. I'm just putting this here so I remember to effect this change
> in another series I'm working on that re-enables the test. Also to not
> tricky reviewers when grepping for "migrate_incoming_qmp".
>

I see, okay.


Thank you.
---
  - Prasad


