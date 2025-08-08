Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPm1-0008Np-1J; Fri, 08 Aug 2025 12:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ukPly-0008Ld-Ha
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ukPlv-0001b3-Oo
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754669804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFMAZWDbRO33G5LEdTR1tBUZBC/zSCOMha9kAWfgrHU=;
 b=XUHb8Tpf+fUCg+Tzi0DSkIbFC5Kbd7EngWMIU1PfyBIp/S8HoQ5FNLU/XlIctVu8h5HlaQ
 iP4NKSz3Gp0tytSvyz5bKWNg4dVwuk6XdbcZQUMLG/Ie0Ua8GCXfnk69tDbL9MwEoli+F4
 sh3tIG8KviE9n2g3V8AEWmYw0U1KLqM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-zsy17Zh8OV-HcgyOuimS9g-1; Fri, 08 Aug 2025 12:16:43 -0400
X-MC-Unique: zsy17Zh8OV-HcgyOuimS9g-1
X-Mimecast-MFC-AGG-ID: zsy17Zh8OV-HcgyOuimS9g_1754669802
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23fd831def4so20601325ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669802; x=1755274602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFMAZWDbRO33G5LEdTR1tBUZBC/zSCOMha9kAWfgrHU=;
 b=rlCC21LRVoI+boS4SIy5nkTsbEkPSSSKY4OCkl/K7fZ0pqH/z/BUT/MPzqlH+nI0ds
 QzTPQaAd/0eud53I3feR5iwbNTvzGryRDHIfu5BnckjW4pxAh9YhVvj4uaiWnzSbvt7+
 YYLdzVfG+kEIEGWOagZKLdW9Vh8OG4N7JNyfO24ISfqx0/ICEVqYGutKCjZBMtk03Y4l
 8koAAHqWvM6OhWEIkFb8inLB56LGeL1SIwpD/tbrpCCvgoCm/+pAUQ0zpnbSLY2GrLjK
 Z8XlalzMum3/nAuN6IUgZxDUyGYO5DFO+1P7iG2DRQxi3BLGI/whyHiBtxaX4OLcqXhV
 Lx2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFy8Yrf0XlIS08iute058Z/rcQBEhLQiuA+tIlcVVfa6SQXShtENYW0C4E3NmhwGDjJCJbrp6JIESx@nongnu.org
X-Gm-Message-State: AOJu0YxGZUEzJHrebl1XUkqQ11xKkFzJMSlnBKOGs/r3/D2poegSPARG
 ZStaaROhWNagtbcUeGG0XHE6XXafKhNyxdM7UQ0B2Ygdh34KVE77px2XwtYahJRO40scsJrCo4d
 8B09ewVK70mU3oLZGZ9t8YBMfTw2be6kEOqYT64g7hBT6y2wwvdfhssNJr0pYPRpeKu5EdXrW8D
 FC8/mTg5FIXmT8dFNl0UqH/4iK2JryiQ8=
X-Gm-Gg: ASbGncv8r/m99K1DQwlkKyXPSQci9gXs6dHglCh2wgVqAXab6AnmljICmBomqqtnh/q
 D0Vst97imPK2IoEQl793v1qaZ1/7Z1ptrUdEy78+YG0iz9JMe/m4kyCTKHIlb0mJ1zNi+uxSGj2
 zo8kon183wVjyokCYb76jJbVtmjLK8L3SRiMXWQRIEU8jOYdKQFjCm
X-Received: by 2002:a17:902:ef0a:b0:240:70d4:85d9 with SMTP id
 d9443c01a7336-242c19a606bmr59388915ad.0.1754669801829; 
 Fri, 08 Aug 2025 09:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbfXLvAVeXfw+nS16wIdqN98gorQ8a5bZ6wEHBRpJAErKw499fGsyBsIcbqdKSkdFrZR6/DXvK+ccC3MJyl70=
X-Received: by 2002:a17:902:ef0a:b0:240:70d4:85d9 with SMTP id
 d9443c01a7336-242c19a606bmr59388495ad.0.1754669801448; Fri, 08 Aug 2025
 09:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
 <CAFn=p-YhYqG5oyWt=zpPCic=2npUkxNJuvuGBuxwthqfMAxL1g@mail.gmail.com>
 <87zfd4v8m5.fsf@pond.sub.org>
 <CAFn=p-biuic_12kWEj==NmNp54MW6X4wf=2hu0edvqJF+deyaw@mail.gmail.com>
 <87o6sqmio8.fsf@pond.sub.org>
In-Reply-To: <87o6sqmio8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 8 Aug 2025 12:16:29 -0400
X-Gm-Features: Ac12FXxX-HOzy-01fSgkLjDiiXfTyF-4ET-zH5k30Sq3vr_5O0x7wDqLl0c52AE
Message-ID: <CAFn=p-ZSMnaedcpUA0x0OVkTgrshCF83Lx4u4Wi0Y1woVT7ThQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
To: Markus Armbruster <armbru@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 8, 2025 at 2:28=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Jul 16, 2025 at 4:32=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Fri, Jul 11, 2025, 10:47=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
> >>
> >> [...]
> >>
> >> >> Exception ignored in: <function QEMUMonitorProtocol.__del__ at 0x7f=
cfcd080d60>
> >> >> Traceback (most recent call last):
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.=
py", line 310, in __del__
> >> >>     self.close()
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.=
py", line 281, in close
> >> >>     self._sync(
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.=
py", line 102, in _sync
> >> >>     return self._aloop.run_until_complete(
> >> >>   File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in=
 run_until_complete
> >> >>     return future.result()
> >> >>   File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_=
for
> >> >>     return await fut
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protoco=
l.py", line 399, in disconnect
> >> >>     await self._wait_disconnect()
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protoco=
l.py", line 719, in _wait_disconnect
> >> >>     await all_defined_tasks  # Raise Exceptions from the bottom hal=
f.
> >> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protoco=
l.py", line 870, in _bh_loop_forever
> >> >>     await async_fn()
> >> >> RuntimeError: cannot reuse already awaited coroutine
> >> >
> >> > Curious about this backtrace. It looks like something has gone
> >> > fundamentally wrong in the internals and the error is being raised b=
y the
> >> > garbage collector which is not ideal.
> >> >
> >> > Can you help me reproduce this? Even if it's old/bad code, I don't w=
ant
> >> > python-qemu-qmp faulting like this.
> >>
> >> Reproducer for Fedora 41, current master c079d3a31e4:
> >>
> >> Run
> >>
> >>     $ qemu-system-x86_64 -S -display none -chardev socket,id=3Dmon1,pa=
th=3Dtest-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,id=3Dqmp,chardev=
=3Dmon1
> >>
> >> and
> >>
> >>     $ scripts/qmp/qom-tree -s test-qmp >/dev/null
> >>
> >> Questions?
> >>
> >
> > Doesn't seem to trigger for me on Fedora 42 from the c079d3a31e4
> > build. Is this a Python version difference thing rearing its head?
>
> I have no idea.
>
> Is there anything else I can do to help you?

Hm. Can you still reproduce this stack trace as of today?

If so, can you please try modifying
qemu.git/python/qemu/utils/qom_common.py and add "import logging" up
at the top, and modify the entry_point classmethod:

>       @classmethod
>      def entry_point(cls) -> int:
>      """
>          Build this command's parser, parse arguments, and run the comman=
d.
>
>          :return: `run`'s return code.
>          """
> +    logging.basicConfig(level=3Dlogging.DEBUG)
>      parser =3D argparse.ArgumentParser(description=3Dcls.help)
>      cls.configure_parser(parser)
>      args =3D parser.parse_args()
>       return cls.command_runner(args)

And then try running the crashy version again, and send me the (quite
likely very long) output?

Note: I really oughtta add a formal --debug/DEBUG=3D1 configuration to
the QOM scripts so this is possible without code modification.


