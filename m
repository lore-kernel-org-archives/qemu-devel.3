Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB23FA3730
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2An-00069s-7v; Fri, 13 Sep 2024 05:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sp2Ak-000698-OI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:00:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sp2Ai-0001v0-6w
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:00:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:1b92:0:640:175a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5737761038;
 Fri, 13 Sep 2024 12:00:49 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8020::1:5] (unknown
 [2a02:6b8:b081:8020::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id l0hcxT1IgSw0-YpwtM3yW; Fri, 13 Sep 2024 12:00:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726218048;
 bh=CTdPUpGKp+/rtZyH1Yrlj93nnEtp9xhh5FXi3aGdO8g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QghVNYt/M91eDnEsgM5Bv2Bhs3WrFdVdWZxhmAEj0RtMrIvf7liPIiNd99p1/LG/S
 SeFCUrK78gjudZFHAKDubXBe+wAqz+1zyx/CtnZHoWIW08SAb2zA32gqautlx95PrN
 zCDlKykuxRWVOh7pi9kKXwoGFrOE6bCKvbk7FC4k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3dc986de-135e-44bf-9b51-606da5b8e660@yandex-team.ru>
Date: Fri, 13 Sep 2024 12:00:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Peter Krempa <pkrempa@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240905085703.106156-1-d-tatianin@yandex-team.ru>
 <87plp80w3g.fsf@pond.sub.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <87plp80w3g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/13/24 11:57 AM, Markus Armbruster wrote:

> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>
>> The 'reconnect' option only allows to specify the time in seconds,
>> which is way too long for certain workflows.
>>
>> We have a lightweight disk backend server, which takes about 20ms to
>> live update, but due to this limitation in QEMU, previously the guest
>> disk controller would hang for one second because it would take this
>> long for QEMU to reinitialize the socket connection.
>>
>> Introduce a new option called 'reconnect-ms', which is the same as
>> 'reconnect', except the value is treated as milliseconds. These are
>> mutually exclusive and specifying both results in an error.
> Good:
>
>      $ upstream-qemu -nodefaults -chardev socket,id=chr0,path=test-hmp,server=off,reconnect=1,reconnect-ms=2
>      upstream-qemu: -chardev socket,id=chr0,path=test-hmp,server=off,reconnect=1,reconnect-ms=2: 'reconnect' and 'reconnect-ms' are mutually exclusive
>
> Bad:
>
>      $ upstream-qemu -nodefaults -S -display none -qmp stdio
>      {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 9}, "package": "v9.1.0-211-ga0866249bd"}, "capabilities": ["oob"]}}
>      {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>      {"return": {}}
>      {"execute":"chardev-add", "arguments": {"id":"chr0", "backend": {"type": "socket", "data": {"server": false, "addr": {"type": "unix", "data": {"path": "xyz"}}, "reconnect": 1, "reconnect-ms": 2}}}}
>      {"return": {}}
>      upstream-qemu: Unable to connect character device chr0: Failed to connect to 'xyz': No such file or directory
>
> We're not rejecting simultaneous use of @reconnect and @reconnect-ms
> here.
>
> Moreover, you somehow regressed the handling of the "unable to connect"
> error.  Before the patch, behavior is correct:
>
>      $ upstream-qemu -nodefaults -S -display none -qmp stdio
>      {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 9}, "package": "v9.1.0-210-g4b7ea33074"}, "capabilities": ["oob"]}}
>      {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>      {"return": {}}
>      {"execute":"chardev-add", "arguments": {"id":"chr0", "backend": {"type": "socket", "data": {"server": false, "addr": {"type": "unix", "data": {"path": "xyz"}}}}}}
>      {"error": {"class": "GenericError", "desc": "Failed to add chardev 'chr0': Failed to connect to 'xyz': No such file or directory"}}

Oh wow, thanks for spotting! I'll be sure to take a look at these.

>> 'reconnect' is also deprecated by this commit to make it possible to
>> remove it in the future as to not keep two options that control the
>> same thing.
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Acked-by: Peter Krempa <pkrempa@redhat.com>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

