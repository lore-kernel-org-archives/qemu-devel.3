Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8527D6CFA7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGQn-0006Vj-LI; Fri, 23 Jan 2026 07:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjGQ8-0006TO-Bt
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjGQ6-0001uW-Pl
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769171865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8IHeKATesNMKMpEW2mv4l1mjd2o+/J2C5NUtBvqhKYs=;
 b=U+Q74GUzaw61C6d8/LPO5r9NVMLL/mQoZAJlFrj6fIkhYlD31q+HAMgmdbSlmi88oiW6aa
 W0NWr3dJJEK1uoZIXbYszcMdwqg2l8by8zgBkWFPdjscZp3ODEAYf01DffEssM/6zUh6ql
 uWCb3u10S3Yx8HdFmPnORTq4ubiCxyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Thlm1IRXNrOuDn-vWqOKgw-1; Fri, 23 Jan 2026 07:37:44 -0500
X-MC-Unique: Thlm1IRXNrOuDn-vWqOKgw-1
X-Mimecast-MFC-AGG-ID: Thlm1IRXNrOuDn-vWqOKgw_1769171863
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5c7a2f54so28343355e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 04:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769171863; cv=none;
 d=google.com; s=arc-20240605;
 b=C/KTyJy0UF5wlHCDkr7aABSHbW4mC39Hzca9QfZ5BdHJBtxwl6GI+DHmbDjL6oks49
 Y2dWFsQSN6TKpvLZT+Vafl/PZk30saZ4cp3Yvt4ebuxTfggT1W7M445lYdRnmmOD0SFr
 fJYo0udmCZTJFCEBorHKe21kVw6QH+UhV7Aiz9nRqybU+8LphVBfy+NgvNEmtZUu+euV
 yZJvvbarL8mqVqPye4NxvciBrhjnvfnTuZlGbhA+hPkPV4FDpO7ATAp37yEOA+Hzzq2u
 RAZK2qd5XO9/i+pyPeZm3m1K+E0O/4p2MkX6eYbvnHDou15VtnJhexnt5pbl7qXdVvV+
 yuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8IHeKATesNMKMpEW2mv4l1mjd2o+/J2C5NUtBvqhKYs=;
 fh=DEybb2UXD9PBV5JklRkcMtmveGBUQm650yQ/EG4ap/8=;
 b=bopItAFbOxtAGQq4xWaog0BMxoJLICIPinep7pSmb34XwAytVk0SD94kc0U8LOy/8l
 YlaPNyeP1zCPdVmi3n5ezfg1arOJz/dg++9GkpD6GBWr3ftajknI7LYRQnQw2MOaTAod
 qba8PBNJcaNGrfn4qLVaa46pGjdNOBX2u4+8ZPU1Fv770VBPmUByTNwFJSEEcM1O+Cqy
 irUbHxYZBvTTq0utKOMmS2RopqOjGbBAvVEnKUUySbx+ZkRbmyKRMK0Be1mOlbnqII5A
 UHe5x4JTk0E35fJIydoM2Lpv+GIZOQW72HKcEOFfBL+RoJ8iH6+vD2aYM+qcuzDAvyd3
 j1yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769171863; x=1769776663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8IHeKATesNMKMpEW2mv4l1mjd2o+/J2C5NUtBvqhKYs=;
 b=BDZiYzIqoTCprpZiu27E4Wotp0ZfsKfcWxOIu4kWrQXlll7ULR2RkeTbZR3aPjx7Gj
 qa/UfkBwbKcK/2Xb5wFOEkOB+xgJ1k9li/0JFOFcEdKt1GAsv5PhUrfp87k8dcMb2yLR
 AOxXgZBRotcCb0cp3G3eSVj90JH30taV2/z6x4fVuRy1ymNM/URfOxU3LrZVcrifJLAi
 woOjG1CgydOC3j8ubXcqqIFh9/eB+ZMe4+L8IjKfry+9B0S9R5c9N3YhjLlJ8JI8WNWy
 cd5rnfaU8NN+2hLBw3A80m/xbSucSjF16Mu1rqEU5L08Bv4GcucRlMLMhKvWR/bstB1p
 N4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769171863; x=1769776663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IHeKATesNMKMpEW2mv4l1mjd2o+/J2C5NUtBvqhKYs=;
 b=PK8GgzX9wMtcxZIuTmUX8UAcwfDX681YYVmlkTegaLKaDnUPL+zaOFjoimv/9gStLa
 Qe38BAVjtCtJrR1WRTIEtfa2wk8QOSWGlLrCpUCN2LujrUbm5xuBzVdzWBB2gMeLlDxv
 DjAEJUYtlkJoQuWZRKhvVtxlgnZbRTXJKIfF3E/nlAen3cVbQAEEZ1zPsoH7BC8YragM
 W5d2Ttg3gNScXzHok87lEpqC2crTj/5/qldXY2EaqW4Hs8lRnDcK+ToqROREF3hadOMg
 RKOdNRriTbGvaay+zx0n9uKwcBJvXyiDDn3QlzBQuSVfoy5ECiFpd92F//Tl+NaEm08N
 lHOA==
X-Gm-Message-State: AOJu0Ywd3QvusMyvPfSyVK2p6TEfyeMj5et6xtpKal9HGLe+Sm4+S6NS
 WtXRNT+shibkSAUMFP3fG9qXFwqqSjfHXL8HtZkhVNJjs+bnD7JWDuBmWu6qHQKlx8SLsLyRZTb
 YWyFustYcBXwlUxpJkbPC8Me36kpsXCHQ/OwTN+y3tyITxStq6DHCp21BvdNtblNRdbA51qnrYl
 iMYW/nj5PN77tzQlzU1QNgzsODtQEpW4Y=
X-Gm-Gg: AZuq6aJhmSLtJRNHnvgNQX40Ioy3E0WpPRC/DMzUPlSPssRYsAZk7KG58f1CdqxCeNh
 OYL922YltA4x+u/dXKiv11vTR9OwuuBYoumQFlulN1ZZpz8Fm2VNx1AHSWIaKKjfF5ZDE/BxWIV
 XLUb6SXpaOthQRbCpU7KOLW4Wqx79qCEhhVfpmBdE28t9MEyun/KISF36rIUBG18KUy0a4wzQ+6
 L8AKZqZhxhMHhAJNcEJVp3ypC8zUdEWcYQzUxKaIrfvDqtdRSNVZVh6
X-Received: by 2002:a05:600c:3209:b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-48047068ca3mr65293815e9.6.1769171862876; 
 Fri, 23 Jan 2026 04:37:42 -0800 (PST)
X-Received: by 2002:a05:600c:3209:b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-48047068ca3mr65293535e9.6.1769171862529; Fri, 23 Jan 2026
 04:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20260122232456.12722-1-farosas@suse.de>
 <CAE8KmOyAYnB8a-AsZvjCFGrX+xwbCjV3Wv2ybVLoBQu7RofOqA@mail.gmail.com>
 <87fr7wjz9v.fsf@suse.de>
In-Reply-To: <87fr7wjz9v.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 23 Jan 2026 18:07:25 +0530
X-Gm-Features: AZwV_QiqqqwrDUgISq51dZMOmdphpsk2rvkomJkBINVH9DkzGwJ-1BizBJPvoe4
Message-ID: <CAE8KmOwWhtTHSh=cbDS7CsgEKS7tf4+HRcJ8ax3Qfnxqgn-YyQ@mail.gmail.com>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

On Fri, 23 Jan 2026 at 17:51, Fabiano Rosas <farosas@suse.de> wrote:
> >> diff --git a/migration/options.c b/migration/options.c
> >> index 9a5a39c886..9dc44a3736 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
> >>          str_or_null = g_new0(StrOrNull, 1);
> >>          str_or_null->type = QTYPE_QSTRING;
> >>          str_or_null->u.s = g_strdup("");                 <== [1]
> >> +        *ptr = str_or_null;
> >>      } else {
> >>          /* the setter doesn't allow QNULL */
> >>          assert(str_or_null->type != QTYPE_QNULL);
> >> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
> >>       */
> >>      str_or_null->type = QTYPE_QSTRING;
> >
> > * Do we need to add:  str_or_null->u.s = g_strdup("");  here?
>
> It would leak, the visitor will allocate new memory for it below.

* Then do we need to remove it from get_StrOrNull()?  <== [1] above.

> I'd rather leave to the caller. The errp will be set, I think it's
> enough. Looking at the other instances of visit_type_str in qdev, they
> all simply return without any handling. I think in practice it's
> unlikely that the string visitors will ever set errp because they are
> just a g_strdup() usually.

* Hmmn, okay. Coverity reported a leak for it in set_StrOrNull(), not
other places?

Thank you.
---
  - Prasad


