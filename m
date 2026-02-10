Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CE6EA810F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnYL-000891-8J; Tue, 10 Feb 2026 08:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpnYE-00087p-Fg
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpnYD-00056s-0y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770729188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oYCYbQ71wwN3V+O0Xv3MsN3c9dBKYdPg//6QoATSmQ=;
 b=PklvdN5I3VYH3b8lQNG6Pd5/1FBHU0JpvKb7zUENz6gu7oiDXTO5lMpYBh+N6XVRaEai9R
 W0E85FRJJ8fAK2PMrewhQ9WTFhtZJ0BXTGKWnVAvcBJ5lpKcrp+Gl+r0/9iMbpYKd9LXwp
 G7syoi6w9mtqcSv11y57u7Tu3hA3h4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-JIjahvAXOC-gNgXCbdlZmQ-1; Tue, 10 Feb 2026 08:13:07 -0500
X-MC-Unique: JIjahvAXOC-gNgXCbdlZmQ-1
X-Mimecast-MFC-AGG-ID: JIjahvAXOC-gNgXCbdlZmQ_1770729186
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43768240a29so1991823f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:13:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770729185; cv=none;
 d=google.com; s=arc-20240605;
 b=PN5iSJVZtoK7pSf8oQIs3Lpu4aU0tIJdgTHjw1yZHyfej2xz5aEwSi8qi32F7e3zLk
 81EwPMzf9Sq7/jeIENo3ST0XLKfSVb6cJz2PYlz0CYE4VOqk11SHgu3xVsM/2CYEyLv1
 /ERJ48JWbOAkPEHWPxrkcPgZmPkJDCDbzw7TEFNQQbxcoYMN8xAofDpu8rzwpN9IgKLX
 WuX1RC6qPmPrPP+TSHH/35UCQ/O6RjC/y5K6IKGXdGond39xHdgFBBzK9GOeAv3bCt/l
 FAjhKI5IKNMiIQMmJAhnewB1GxR929YXrgEH43L78GGJFJwRWGkE3eGTPJOWvpR24QX3
 sgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/oYCYbQ71wwN3V+O0Xv3MsN3c9dBKYdPg//6QoATSmQ=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=ZLRbzfl0qVexYMkT4wHRbWD/jnfUw8hTJ76jGAW3FPUMCDPc6AGDgvZrtIlve9Bh41
 eZTcAa0DBsR/6uHiSrn8hmsMMgvAGUMqJZr11gJjRLi3sR0ecgHSfLlm0exa4zLL8PCT
 n+zJbeMgxdwZmPzWwqpFgq/SAurbmCzIAEj3V+c/GeI4pzoHBAZIu7KDW3vCHCjtPWxL
 WsVj2mw59mWEh1NQQ22Ujf1kVHDYTNcYHENHOw2ZFKapKZVsaEYwN64ecgV1cMMDr/nK
 Y5tdZQxy1POqnuAbmAVJYRIsU47RK3lYJ1HBqLNSTa8sVEKnTNJs1yv591/kkeWlkEuI
 ncwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770729185; x=1771333985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oYCYbQ71wwN3V+O0Xv3MsN3c9dBKYdPg//6QoATSmQ=;
 b=PRiyAMSMoWDzTr1ukNWCfJzD4FCHEqFCUP0vUy1iiR9QN8GKo6yYQHHXAUnlAMuSh3
 p3/XEGu5q2VapZzw7Hz7NFiFd99t0oaYLiHFLFbEP1EyqTBLqlSZmPXtNMx6TxqzDKSe
 ynJ/zZvcCncAnq3SND+QgWB/NjtTpW83GChDnfisV0OcsyTmosQa0z1Te4ssk/PPg2od
 bbPY44KrOrmBlFq9r7FSAoOPgvJQKmY+jjesSrA+QxvsXiVMNX35qDzm3JIom//ZOmaH
 ZFKpXDk/SDW0f5DT/rrufzE6AMW+CNAHzOlIjTT9Tnu6gD+s9Rk3yYrBzxQ6RdnoQnFK
 wFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770729185; x=1771333985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/oYCYbQ71wwN3V+O0Xv3MsN3c9dBKYdPg//6QoATSmQ=;
 b=JL7ZGgzsfAN6YvJ/htwOXp3AuZSfa0/rVoKVaH2Pw1w4j5Nc1l8qmx9I5HKVg7ScW6
 cpJD5s+crQ1YP6sPSoyr3aPnk7isWhH7aF+kp53n5Ev6NsMaQOEs12phuttUNoW2OmR4
 +4JWzeuY5SV3jTOO8XBkSp/O+FyGldAaRmqCeu/d6z7kUfTGQzC3zHN/kgCy5eKO7F7g
 cs09D4ErNTgLrhdHaLz5oEPqIO1/K4rzQlsw5Xs+cpEG9mh45XXYvTci75MAWfrgRWIA
 2WRSintmGKDWEO9ZG5lfz4Zb+oXW/0Wd7DPuXxPnftY8mh8VNiFkqx9VRT3NSYaxad9l
 ghQA==
X-Gm-Message-State: AOJu0YyxEqWlBaJip77FJORkK+zy3YQuQF+ynaPoIMOlw11ED5LNGyVY
 d2bRiytLTDzo7JvcakHdO+D1U4kluHhl9tG4JkyFOH+qzoQg1tLgfL8k0lyBnbUI4/xbWGjXhaT
 1FMVMbdBFftxEYK8DytdJ37yJH6UAOMg+gFc9FmciJ86lhStD9bH0Q2Zbn8LI/R9GcjM3A4IdfF
 pD2GCjX6FPiKYZVeoGuGOIaNREpUhsOJ5v4cO49haZAA==
X-Gm-Gg: AZuq6aJvY3RIRaD2xiAcg63JyUHq7SckPQplMzWliXNzF883Uq9nD3ND3ESIowKw+N3
 tqVz1vfu1jVuqH329HELTk3h3phO6Fyle2TOZMqhpqCvNfLL4MQ55OUHEREwR44O9BVwFiPODrI
 Fu6o2NwhepOimOSXaNSJZl604klMdXPS1k2Ta7EmIavhvjGN6Sn4u8LKSSOGgQrIAQ7ei6NdfQc
 M88ixN+5pmIuw+8a4OJEmF9m+OXLOikNL7I7Tyzg6MqlN+M2Cb6DVK+Pbc8Wj7Si1cyOnDe3PmO
 nrIOpw==
X-Received: by 2002:a5d:5f92:0:b0:436:339a:9a9f with SMTP id
 ffacd0b85a97d-43779fe26damr4220354f8f.10.1770729185204; 
 Tue, 10 Feb 2026 05:13:05 -0800 (PST)
X-Received: by 2002:a5d:5f92:0:b0:436:339a:9a9f with SMTP id
 ffacd0b85a97d-43779fe26damr4220297f8f.10.1770729184720; Tue, 10 Feb 2026
 05:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <87ldhffe79.fsf@pond.sub.org>
 <CABgObfYD6cLmN_qgmro-O2wUPqnqTn3ZUYntbPrFQkX0xE=8AQ@mail.gmail.com>
 <87o6lw7nor.fsf@pond.sub.org>
In-Reply-To: <87o6lw7nor.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Feb 2026 14:12:51 +0100
X-Gm-Features: AZwV_Qh9DBx4aYc8bqVBfqq00Yb8syQq8CPZ1hCwnSzxZCd9bn83WE8TKQUvQ7c
Message-ID: <CABgObfYrMS093t4GoxB8EgwYYT8wCb-MBozgC5ATq3BZdpheBA@mail.gmail.com>
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 10, 2026 at 2:06=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
> >                                                                     Sti=
ll
> > the difference in error reporting matters, because it gives feedback th=
at
> > is immediately useful, rather than possibly delayed forever.
>
> Reporting parse errors immediately is such a lovely quality of life
> improvement.  May I have that without regressing error recovery?

If it is a regression, of course.

Especially the one for ^L, which needs a testcase. Something like this
should do:

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index f6380684897..287a345b49a 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -35,17 +35,25 @@
         parser->brace_count++;
         break;
     case JSON_RCURLY:
-        if (parser->brace_count > 0) {
-            parser->brace_count--;
+        if (parser->brace_count <=3D 0) {
+            goto end_error_recovery;
         }
+        parser->brace_count--;
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
-        if (parser->bracket_count > 0) {
-            parser->bracket_count--;
+        if (parser->bracket_count <=3D 0) {
+            goto end_error_recovery;
         }
+        parser->bracket_count--;
+        break;
+    case JSON_ERROR:
+    end_error_recovery:
+        parser->brace_count =3D 0;
+        parser->bracket_count =3D 0;
         break;
     default:
         break;

Thanks,

Paolo


