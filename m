Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AF2C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 22:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk8j8-0001oi-Dd; Thu, 07 Aug 2025 18:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8iw-0001mF-JV
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 18:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8it-00005H-12
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 18:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754604268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYMBe/8GXVMRlJZ3uwlOY4weqC/+CjfuFywjDSFUZkc=;
 b=PMezY0e4dTyt6dLvPTyHbStZEzpZLpvV1aP8MmqRGoCP4RDm28w3SQt1JIl73MZtyO0lFp
 TRgqVvfwl7xu8tRddCAsgbI6+whGNXfzoGQjZMPF2OuDE8C1Kw10UoeSkqouZeTa96rc3Z
 +QheGRNLfNZdwiEZEfekD2C2UZMMTew=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-mePacOdvM6GVHdYCwD0nsQ-1; Thu, 07 Aug 2025 18:04:27 -0400
X-MC-Unique: mePacOdvM6GVHdYCwD0nsQ-1
X-Mimecast-MFC-AGG-ID: mePacOdvM6GVHdYCwD0nsQ_1754604266
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2425364e0b2so16738945ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 15:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754604266; x=1755209066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYMBe/8GXVMRlJZ3uwlOY4weqC/+CjfuFywjDSFUZkc=;
 b=wMmXvDT2usl1v3mdYGlJObVg/WJfAmB/LJlT/BmTZiqrMCppUw5H5j5AH8hdDHZy90
 oLgBQpMLTNBTAcCo/H5XVkPDojH6wgF5NYvhynTHHPzzsGZ1uXT7OWBZOk2xsiLwny92
 yByzLKq9o675vikWBICO14SVkETwVotp4kCrXi4kW69+jh4nWWBHR1SUrzCu3XzAEAHi
 /zcUvxD4tdnbC0jCRphSmNzZVFJg0i7vGU6wzwPPsIlu6kScub33B45fy+pEJ9hnQJjl
 g4dviaXGDIAoG2iHmC3qHmAy/jEmzkPLRMcrd3nwjdZsw75+rfPLCHOsvXXlOU8CSuw3
 e/8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdRCY9UgJ7S1cpIf36q6pV+A5GRyVTZ9D1W9ZAGz8eKNSMmtUCK56R1dZPsnrtZirqiEjPzllO/iJZ@nongnu.org
X-Gm-Message-State: AOJu0YzovY1UDAohNIJjGC8N4kSV/lsVCe6Tl1iK8aHI9aKvqaPjIGAh
 jtyRpKK0hGxyj+7CwOHw0C6GTkqMk33wCrIZa1JRuODmwHj3y68RT6SGq6JVkDH2n40TZVrWScH
 cFTMBOPlk6/L0UhT0P+fLyVPDddhWdqkghLzyrA07cqxmZHk5VbmUy5Z44HFUuwdWUl2kkfuz94
 I8nqhEFQd/0GzpkkMBXU0BXAqvlxH9+UY=
X-Gm-Gg: ASbGncu1QF+kWNAoudQKs7vpHOgmqG45gtacXwbiRsQgAI/jaC53vqlbCURQaQuxQfd
 q25zP7fDBZ2Kp8CPwBzLAqTzzn9xW6I6neDx4ahnDKXadhGVsXnNuK8O7DixI5TdLNJldSUnver
 y+XD+uw+773y94yLEKTuRlBvL0+h13DKoDlSEd/B3YkyDzjKAq8pWb
X-Received: by 2002:a17:903:28d:b0:240:934f:27ac with SMTP id
 d9443c01a7336-242c21e01ebmr8306725ad.33.1754604266392; 
 Thu, 07 Aug 2025 15:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtdnMTQ3p9uCyUQkDjoT9YPZTnXYP8CSyIFVsJi6CLt6J4TAy4CvAYsTk4HHvKCIe35tTw+JTXTSd8K1y81wQ=
X-Received: by 2002:a17:903:28d:b0:240:934f:27ac with SMTP id
 d9443c01a7336-242c21e01ebmr8306475ad.33.1754604265996; Thu, 07 Aug 2025
 15:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
 <CAFn=p-YhYqG5oyWt=zpPCic=2npUkxNJuvuGBuxwthqfMAxL1g@mail.gmail.com>
 <87zfd4v8m5.fsf@pond.sub.org>
In-Reply-To: <87zfd4v8m5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Aug 2025 18:04:14 -0400
X-Gm-Features: Ac12FXyHt8QFluB9Cz4jbZp9csbvKqgBQWDKMZ0N8lPZMAUCCscpcCWSk7VHrAQ
Message-ID: <CAFn=p-biuic_12kWEj==NmNp54MW6X4wf=2hu0edvqJF+deyaw@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jul 16, 2025 at 4:32=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Jul 11, 2025, 10:47=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>
> [...]
>
> >> Exception ignored in: <function QEMUMonitorProtocol.__del__ at
> >> 0x7fcfcd080d60>
> >> Traceback (most recent call last):
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py"=
,
> >> line 310, in __del__
> >>     self.close()
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py"=
,
> >> line 281, in close
> >>     self._sync(
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py"=
,
> >> line 102, in _sync
> >>     return self._aloop.run_until_complete(
> >>   File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in
> >> run_until_complete
> >>     return future.result()
> >>   File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
> >>     return await fut
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.p=
y",
> >> line 399, in disconnect
> >>     await self._wait_disconnect()
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.p=
y",
> >> line 719, in _wait_disconnect
> >>     await all_defined_tasks  # Raise Exceptions from the bottom half.
> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.p=
y",
> >> line 870, in _bh_loop_forever
> >>     await async_fn()
> >> RuntimeError: cannot reuse already awaited coroutine
> >>
> >
> > Curious about this backtrace. It looks like something has gone
> > fundamentally wrong in the internals and the error is being raised by t=
he
> > garbage collector which is not ideal.
> >
> > Can you help me reproduce this? Even if it's old/bad code, I don't want
> > python-qemu-qmp faulting like this.
>
> Reproducer for Fedora 41, current master c079d3a31e4:
>
> Run
>
>     $ qemu-system-x86_64 -S -display none -chardev socket,id=3Dmon1,path=
=3Dtest-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,id=3Dqmp,chardev=3Dm=
on1
>
> and
>
>     $ scripts/qmp/qom-tree -s test-qmp >/dev/null
>
> Questions?
>

Doesn't seem to trigger for me on Fedora 42 from the c079d3a31e4
build. Is this a Python version difference thing rearing its head?


