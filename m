Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3390C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXz6-00087B-2w; Wed, 24 Jan 2024 02:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1rSXz4-00086T-8A; Wed, 24 Jan 2024 02:47:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1rSXz2-0003xB-FL; Wed, 24 Jan 2024 02:47:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7C431F7D9;
 Wed, 24 Jan 2024 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706082456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDr2B6lRtf9LnJ9Knl1hJjrmRKFftqS2Xzh4IEhZcgs=;
 b=DbCSN5LrOW95l77TOfoifsXsMSQR95DJo93xDBsUWFJm02ihZIi4JiXZPbSy+MBkTGbF6m
 xe5HywV2mPoE9SwdRHGCRcn2HuSt4lS50mLCQw1LAuEL1QNgu1zeMS8LibwYgUhsnOtzfZ
 H2O7CJnsnO7239XP/Yiccee6v8AujEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706082456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDr2B6lRtf9LnJ9Knl1hJjrmRKFftqS2Xzh4IEhZcgs=;
 b=6IFhv0kh2S4CxXMPk2Ub2wKysOCE/Z7hTs+H0MNQzwjoncFDYBu/Qjfx9oWgYz3HYEbHzv
 1uf/pt1bol2P5yDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706082456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDr2B6lRtf9LnJ9Knl1hJjrmRKFftqS2Xzh4IEhZcgs=;
 b=DbCSN5LrOW95l77TOfoifsXsMSQR95DJo93xDBsUWFJm02ihZIi4JiXZPbSy+MBkTGbF6m
 xe5HywV2mPoE9SwdRHGCRcn2HuSt4lS50mLCQw1LAuEL1QNgu1zeMS8LibwYgUhsnOtzfZ
 H2O7CJnsnO7239XP/Yiccee6v8AujEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706082456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDr2B6lRtf9LnJ9Knl1hJjrmRKFftqS2Xzh4IEhZcgs=;
 b=6IFhv0kh2S4CxXMPk2Ub2wKysOCE/Z7hTs+H0MNQzwjoncFDYBu/Qjfx9oWgYz3HYEbHzv
 1uf/pt1bol2P5yDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA38E1333E;
 Wed, 24 Jan 2024 07:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TcJPLJjAsGWQWwAAD6G6ig
 (envelope-from <hare@suse.de>); Wed, 24 Jan 2024 07:47:36 +0000
Message-ID: <07625f96-4ca1-479f-b6b9-69c2a191de76@suse.de>
Date: Wed, 24 Jan 2024 08:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVME hotplug support ?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Damien Hedde <dhedde@kalrayinc.com>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Titouan Huard <thuard@kalrayinc.com>, 
 Markus Armbruster <armbru@redhat.com>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
 <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 SUBJECT_ENDS_QUESTION(1.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=hare@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 07:52, Philippe Mathieu-Daudé wrote:
> Hi Hannes,
> 
> [+Markus as QOM/QDev rubber duck]
> 
> On 23/1/24 13:40, Hannes Reinecke wrote:
>> On 1/23/24 11:59, Damien Hedde wrote:
>>> Hi all,
>>>
>>> We are currently looking into hotplugging nvme devices and it is 
>>> currently not possible:
>>> When nvme was introduced 2 years ago, the feature was disabled.
>>>> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
>>>> Author: Klaus Jensen
>>>> Date:   Tue Jul 6 10:48:40 2021 +0200
>>>>
>>>>     hw/nvme: mark nvme-subsys non-hotpluggable
>>>>     We currently lack the infrastructure to handle subsystem 
>>>> hotplugging, so
>>>>     disable it.
>>>
>>> Do someone know what's lacking or anyone have some tips/idea of what 
>>> we should develop to add the support ?
>>>
>> Problem is that the object model is messed up. In qemu namespaces are 
>> attached to controllers, which in turn are children of the PCI device.
>> There are subsystems, but these just reference the controller.
>>
>> So if you hotunplug the PCI device you detach/destroy the controller 
>> and detach the namespaces from the controller.
>> But if you hotplug the PCI device again the NVMe controller will be 
>> attached to the PCI device, but the namespace are still be detached.
>>
>> Klaus said he was going to fix that, and I dimly remember some patches
>> floating around. But apparently it never went anywhere.
>>
>> Fundamental problem is that the NVMe hierarchy as per spec is 
>> incompatible with the qemu object model; qemu requires a strict
>> tree model where every object has exactly _one_ parent.
> 
> The modelling problem is not clear to me.
> Do you have an example of how the NVMe hierarchy should be?
> 
Sure.

As per NVMe spec we have this hierarchy:

      --->  subsys ---
     |                |
     |                V
controller      namespaces

There can be several controllers, and several
namespaces.
The initiator (ie the linux 'nvme' driver) connects
to a controller, queries the subsystem for the attached
namespaces, and presents each namespace as a block device.

For Qemu we have the problem that every device _must_ be
a direct descendant of the parent (expressed by the fact
that each 'parent' object is embedded in the device object).

So if we were to present a NVMe PCI device, the controller
must be derived from the PCI device:

pci -> controller

but now we have to express the NVMe hierarchy, too:

pci -> ctrl1 -> subsys1 -> namespace1

which actually works.
We can easily attach several namespaces:

pci -> ctrl1 ->subsys1 -> namespace2

For a single controller and a single subsystem.
However, as mentioned above, there can be _several_
controllers attached to the same subsystem.
So we can express the second controller:

pci -> ctrl2

but we cannot attach the controller to 'subsys1'
as then 'subsys1' would need to be derived from
'ctrl2', and not (as it is now) from 'ctrl1'.

The most logical step would be to have 'subsystems'
their own entity, independent of any controllers.
But then the block devices (which are derived from
the namespaces) could not be traced back
to the PCI device, and a PCI hotplug would not
'automatically' disconnect the nvme block devices.

Plus the subsystem would be independent from the NVMe
PCI devices, so you could have a subsystem with
no controllers attached. And one would wonder who
should be responsible for cleaning up that.

Cheers,

Hannes


