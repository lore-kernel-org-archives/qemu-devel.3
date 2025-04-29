Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C7EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mlT-00015c-Ir; Tue, 29 Apr 2025 11:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9mlO-0000zW-Ub
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9mlI-0003vd-6C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745940041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyzFVjatxS36KJ9rYJoavpDJAz9S5JYQSu7Cx8uAJeA=;
 b=WgeF+12ErC+VyU607kTYLAxq98kzrg/oFaZA8WLePGbhBbqXSmiZplEJnJMGlSxnaxwpKp
 UG+t1fQkLboreLlPACKKjzOSPyfBvDKH0dAIZL/U+wlY13mHaRpfWf6jTjzVBJrvFr4L1J
 xQhSBiQeVgWC+RLDyNhKQM8g78JgDd4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-MGVlrZMsNoGsivRfXBmamQ-1; Tue, 29 Apr 2025 11:20:39 -0400
X-MC-Unique: MGVlrZMsNoGsivRfXBmamQ-1
X-Mimecast-MFC-AGG-ID: MGVlrZMsNoGsivRfXBmamQ_1745940038
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so32386005e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940037; x=1746544837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UyzFVjatxS36KJ9rYJoavpDJAz9S5JYQSu7Cx8uAJeA=;
 b=u3p1oj2rUd+7XgQAKVbZLO20i41pMoPf051LPsm//4Tb2eVBaMhBfE+qaB8XHA4Szi
 dhtB/W7AoAzrs6sKMoYtbLkhdhVpG4hJgU3lpOLEkCysY8XZzdDeV1ClVTCrx8b6uJSl
 pRCL9zJfFHMDji1BY5tLcO/FmeqYFflvgTp82lyH5vy78Jp2i+UnemlIPeZUPllyXNBJ
 WSx8vkB1jw0MMFwtDfaBg/og21ziClhj13KurAV/BYIn1n8RDENVNYNHMldPxGvnB1Gj
 yKSw4B9N2LUpX5NiAGe11VzBjqdtCl9+7va6Rq9IkR39YXbeGF1PQxocy0ljMckh7dpz
 KyeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZbZ3wMR+E1ZRjsIrmJcMWzIFmywGBZEpwTbOLm3SlhRf+Kox4ScgQ8VRxMO2sw7EkJr2OFlRM82ct@nongnu.org
X-Gm-Message-State: AOJu0Yyv5aE8BCgSwQ9zI0tZr4u59R7Qz5m+DsZlAY9qB9YbwuAd/z6e
 UjI+uMjDcsIOF4hdCMdgIRCy/gGFzeYA1wJwBrAGsuhMw6mgj80Tkjd1jU5LJvZo19eYarG9Qpp
 6Txeiu3QHneSd2A82/uhIn3Fb6e3lK90g6sypAyc019HnulxaMjYoXDxxCD9fXSQlT9FSnx/V22
 GfBcTx+TZV9RPvJ9HgUGcn/QygJLM=
X-Gm-Gg: ASbGnctdmGDANBXcqp7cum7YUZaXiyBC0vUB1FdexCP7mZ8P4jzzkCwvgzvs5PoZvKH
 V0YzcERm5GnjhoJOdn+UQm7p0uEWEhihePgioAo5QcJ+bNVWhEZm6gJcdXISFDNj7MA7r
X-Received: by 2002:a05:600c:384d:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-440ab848aa3mr111520905e9.26.1745940037554; 
 Tue, 29 Apr 2025 08:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxfJgVbiYQNxsI7gP8lEH6I+T3LgwKZYpuj5+Oduk4S9a9TqHCMh/UCFpr+lwWGdaoYalZd1/0r/Zb4IIQtr0=
X-Received: by 2002:a05:600c:384d:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-440ab848aa3mr111520695e9.26.1745940037250; Tue, 29 Apr 2025
 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
 <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
 <aBDYj3k83_W6ihlF@x1.local>
In-Reply-To: <aBDYj3k83_W6ihlF@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 29 Apr 2025 20:50:19 +0530
X-Gm-Features: ATxdqUEU6YQfcF5v5zsh2GUgJImggSwi4bE9dDG6qbpn-Wn137uYIOK6Se1FKVY
Message-ID: <CAE8KmOxR1EoyLK6+49bVJK9BW0NfhgEcE2_aVxQQjkBY9y1xwA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 29 Apr 2025 at 19:18, Peter Xu <peterx@redhat.com> wrote:
> Please don't rush to send. Again, let's verify the issue first before
> resending anything.
>
> If you could reproduce it it would be perfect, then we can already verify
> it.  Otherwise we may need help from Fabiano.  Let's not send anything if
> you're not yet sure whether it works..  It can confuse people thinking
> problem solved, but maybe not yet.

* No, the migration hang issue is not reproducing on my side. Earlier
in this thread, Fabiano said you'll be better able to confirm the
issue. (so its possible fix as well I guess)

* You don't have access to the set-up that he uses for running tests
and merging patches? Would it be possible for you to run the same
tests? (just checking, I don't know how co-maintainers work to
test/merge patches)

* If we don't send the patch, how will Fabiano test it? Should we wait
for Fabiano to come back and then make this same patch in his set-up
and test/verify it?

Thank you.
---
  - Prasad


