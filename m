Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B74C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 18:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWfJC-0003XH-N1; Tue, 01 Jul 2025 14:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uWfJB-0003Wl-DW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:02:17 -0400
Received: from che.mayfirst.org ([2001:470:1:116::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkg@fifthhorseman.net>)
 id 1uWfJ9-0008RE-9b
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:02:17 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; s=2019;
 t=1751392931; h=from : to : cc : subject : in-reply-to : references :
 date : message-id : mime-version : content-type : from;
 bh=acbPrRIDpGLlCvJ569ptlghoiP2o2VB0+xw6ejV0Z2c=;
 b=bLulJUzH6VbW+9EbShT4kF5zv1DrCc4zcLk3DHp/cmQRiiHu+m/fIqUi+IwR0RPTLDKtn
 uq8G353aBaeLShzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net;
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1751392931; h=from : to
 : cc : subject : in-reply-to : references : date : message-id :
 mime-version : content-type : from;
 bh=acbPrRIDpGLlCvJ569ptlghoiP2o2VB0+xw6ejV0Z2c=;
 b=DsuabNL6eZ+XZVvEIlP2DRqt67zSPP14nELvWPAIQzKKVCRd/4eDHfBIrjPMxSwBsPFwI
 nvgIBvKiCxWn5PgIGue9Yx/Z0EM+zFr2+XOIjE+71n2Y64xfK2vklg3Jw+wJvhk3VTdZS0D
 6Wbz7EF14IRliZfkxwmfyNDqoBF/NzYzNfiapYVgFUsrWkHfMdzjIDRjLhXiHzugZTF504+
 tUXEA6tXd33TYlK8G2DwcNYTxXwLRdAJvpUJ9arZ6YOtcVl/d2tIjyQGd6ZV5mRImeH/YwG
 hbK0ZJdzhQpO9S4uafX7rxfOPYInfHnnFmmZOPerQVNzg4aZ1hUYSBF9EWrQ==
Received: from fifthhorseman.net (AMERICAN-CI.ear2.NewYork6.Level3.net
 [4.59.214.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by che.mayfirst.org (Postfix) with ESMTPSA id 5FDB0F9B1;
 Tue,  1 Jul 2025 14:02:11 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
 id 4492D13F6B3; Tue, 01 Jul 2025 14:02:06 -0400 (EDT)
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] Socket activation: enable spice listener.
In-Reply-To: <aGOsek0xeyXk3G6y@redhat.com>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250627180331.1370235-3-dkg@fifthhorseman.net>
 <aGOsek0xeyXk3G6y@redhat.com>
Autocrypt: addr=dkg@fifthhorseman.net; prefer-encrypt=mutual; keydata=
 xjMEZXEJyxYJKwYBBAHaRw8BAQdA5BpbW0bpl5qCng/RiqwhQINrplDMSS5JsO/YO+5Zi7HNFzxk
 a2dAZmlmdGhob3JzZW1hbi5uZXQ+wsARBBMWCgB5AwsJB0cUAAAAAAAeACBzYWx0QG5vdGF0aW9u
 cy5zZXF1b2lhLXBncC5vcmcS78JIJ7JbALqPiKEmva7/Pp16WwXWm9hbe5+B/UvnfwMVCggCmwEC
 HgEWIQTUdwQMcMIValwphUm7fpEBSV5r9wUCZadfkAUJBdnwRQAKCRC7fpEBSV5r9yNXAP442N0c
 zvisBroQSKKpo+OWm2JpnEJWoVheeJvoRtkBGQEA+edHylby8IGcNccq7rmM2rAXdofvrU1o6qow
 V+mmDwbOMwRnio4OFgkrBgEEAdpHDwEBB0Cw9HzJFl9lZn3UBaUqSMSgxjcdbd0MwNVcGZ8t8wdN
 EcLAvwQYFgoBMQWCZ4qODgkQu36RAUlea/dHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9p
 YS1wZ3Aub3JnhcN+tn41cAg01Kk56zcAfpdsh8j98PDe00mqKPfFvaYCmwK+oAQZFgoAbwWCZ4qO
 DgkQeAuFTtnCtJZHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9pYS1wZ3Aub3JnxsD8Sk5P
 Wgx8c/Zseo6OlCjyDC+Ogm17gTaUUIpxjWYWIQRjrBGOWy5dZsiKhad4C4VO2cK0lgAAdcQA/1RG
 dmrmvVxkBY2qNPjtERNwPga8Pf4IdlenrZ03NXM4AQC+TDHMpD7d5obEvUy8GYI3oThzYItPP8vv
 ChY+wbaIBRYhBNR3BAxwwhVqXCmFSbt+kQFJXmv3AAAKbgD+K1MZXnRKPdmA8DgNysyGRZY8cSVH
 HQcC7ZAAtV3i2+wA/0CyOYrbFYbyTRALgoERR07OHFoP+fJopQLMNQARVUELzjgEZ4qN+RIKKwYB
 BAGXVQEFAQEHQDTGlR+Qmn334e+bPqvojJVdFsiBf0leAAHP+ESqop8NAwEIB8LAAAQYFgoAcgWC
 Z4qN+QkQu36RAUlea/dHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9pYS1wZ3Aub3JnA5Lw
 b3wOOcoodImuVNw4PYq1U65FDC1Q2JMFIcJXqF0CmwwWIQTUdwQMcMIValwphUm7fpEBSV5r9wAA
 6egA/j3QANSmogZ5VTF5KlI+BBye9ud/w9j7RLcCHU6u8AA1AQC3FGaNuv+uWOSa+eeEoI/aZrGd
 X5el8b/m6aXDDxDjDg==
Date: Tue, 01 Jul 2025 14:02:05 -0400
Message-ID: <871pqz6b8i.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Received-SPF: pass client-ip=2001:470:1:116::7;
 envelope-from=dkg@fifthhorseman.net; helo=che.mayfirst.org
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

--=-=-=
Sig: t=p; b=iHUEARYKAB0WIQRjrBGOWy5dZsiKhad4C4VO2cK0lgUCaGQingAKCRB4C4VO2cK0
 lt3oAQDoiA6PXiTf/2tyaJDL7IYIuBpflpcOs/HKWv6hLRW5GwEA6pQmNU3Qubl1
 vs55xPvl018KqXv6ENUMhs3acuONkg0=
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] Socket activation: enable spice listener.
In-Reply-To: <aGOsek0xeyXk3G6y@redhat.com>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250627180331.1370235-3-dkg@fifthhorseman.net>
 <aGOsek0xeyXk3G6y@redhat.com>
Autocrypt: addr=dkg@fifthhorseman.net; prefer-encrypt=mutual; keydata=
 xjMEZXEJyxYJKwYBBAHaRw8BAQdA5BpbW0bpl5qCng/RiqwhQINrplDMSS5JsO/YO+5Zi7HNFzxk
 a2dAZmlmdGhob3JzZW1hbi5uZXQ+wsARBBMWCgB5AwsJB0cUAAAAAAAeACBzYWx0QG5vdGF0aW9u
 cy5zZXF1b2lhLXBncC5vcmcS78JIJ7JbALqPiKEmva7/Pp16WwXWm9hbe5+B/UvnfwMVCggCmwEC
 HgEWIQTUdwQMcMIValwphUm7fpEBSV5r9wUCZadfkAUJBdnwRQAKCRC7fpEBSV5r9yNXAP442N0c
 zvisBroQSKKpo+OWm2JpnEJWoVheeJvoRtkBGQEA+edHylby8IGcNccq7rmM2rAXdofvrU1o6qow
 V+mmDwbOMwRnio4OFgkrBgEEAdpHDwEBB0Cw9HzJFl9lZn3UBaUqSMSgxjcdbd0MwNVcGZ8t8wdN
 EcLAvwQYFgoBMQWCZ4qODgkQu36RAUlea/dHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9p
 YS1wZ3Aub3JnhcN+tn41cAg01Kk56zcAfpdsh8j98PDe00mqKPfFvaYCmwK+oAQZFgoAbwWCZ4qO
 DgkQeAuFTtnCtJZHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9pYS1wZ3Aub3JnxsD8Sk5P
 Wgx8c/Zseo6OlCjyDC+Ogm17gTaUUIpxjWYWIQRjrBGOWy5dZsiKhad4C4VO2cK0lgAAdcQA/1RG
 dmrmvVxkBY2qNPjtERNwPga8Pf4IdlenrZ03NXM4AQC+TDHMpD7d5obEvUy8GYI3oThzYItPP8vv
 ChY+wbaIBRYhBNR3BAxwwhVqXCmFSbt+kQFJXmv3AAAKbgD+K1MZXnRKPdmA8DgNysyGRZY8cSVH
 HQcC7ZAAtV3i2+wA/0CyOYrbFYbyTRALgoERR07OHFoP+fJopQLMNQARVUELzjgEZ4qN+RIKKwYB
 BAGXVQEFAQEHQDTGlR+Qmn334e+bPqvojJVdFsiBf0leAAHP+ESqop8NAwEIB8LAAAQYFgoAcgWC
 Z4qN+QkQu36RAUlea/dHFAAAAAAAHgAgc2FsdEBub3RhdGlvbnMuc2VxdW9pYS1wZ3Aub3JnA5Lw
 b3wOOcoodImuVNw4PYq1U65FDC1Q2JMFIcJXqF0CmwwWIQTUdwQMcMIValwphUm7fpEBSV5r9wAA
 6egA/j3QANSmogZ5VTF5KlI+BBye9ud/w9j7RLcCHU6u8AA1AQC3FGaNuv+uWOSa+eeEoI/aZrGd
 X5el8b/m6aXDDxDjDg==
Date: Tue, 01 Jul 2025 14:02:05 -0400
Message-ID: <871pqz6b8i.fsf@fifthhorseman.net>
Content-Type: text/plain; charset=utf-8; hp="clear"
Content-Transfer-Encoding: quoted-printable

Hi Daniel--

Thanks for the followup and the background.  What you say makes sense to
me, but i don't know enough about the plumbing to know how i would go
about trying to help make it happen.  I ask a few questions below for
hints on how i might move forward.

On Tue 2025-07-01 10:38:02 +0100, Daniel P. Berrang=C3=A9 wrote:
> Spice is rather an odd-ball part of QEMU today that isn't using modern
> best practice config design, so what looks simple from a Spice POV is
> not aligned with what we need for QEMU.

Fair enough, i'd be happy to put the spice work on the back burner and
get the systemd socket activation by named file descriptor normalized
first.

> IMHO for systemd socket activation, we want to introduce the ability
> to reference sockets by name at startup, so it is aligned with what
> we can do at runtime.

Agreed, this makes sense to me.

> Primarily this comes down to having logic present in the socket_get_fd
> method, such that when there is no current monitor, we use the systemd
> named sockets.

I'm not sure how the monitor plays a role here.  Are you talking about
having a socket-activated monitor specifically, or do you see the
monitor playing some special role in socket activation beyond just being
yet another file descriptor that might be passed in via systemd-style
supervision?  why wouldn't it be OK to have a monitor *and* use systemd
named sockets? Looking at socket_get_fd, i see that it's resolving the
fdstr differently if there is a current monitor; is that codepath only
active after all command-line arguments have been processed?

> We should also have logic to validate that we have consumed all
> systemd sockets, before we move out of startup phase, in order to
> detect config errors. This indicates should we proactively parse
> the socket activation env at starutp and record all FDs, and keep
> track of which are consumed by the config.

Could you be a bit more specific about how the "startup phase" is
delimited within the codebase?  I'd be happy to try to build out
something similar to what you describe here, if you think that would be
useful.  I'd want to make sure i place the check for all passed file
descriptors being accounted for in the right place.

> Meanwhile both -vnc and -spice need updating to have their CLI
> modelled in QAPI, and use the SocketAdddress struct config, which
> would unlock FD passing both with & without systemd socket activation.

I'm happy to leave the -vnc and -spice alone for now, if we can get
name-based socket activation normalized and stable.

> And then there are some hard questions about how we integrate this with
> the various helper programs like qemu-nbd, and friends, which all
> already support systemd socket activation but fail to validate the
> names, making it hard to add propert support while retaining back compat.

Understood -- from looking at the sources i think that means this
specific list of four helper programs:

 - qemu-nbd (network block device server)
 - qemu-ga (the qemu guest agent)
 - qemu-pr-helper (qemu SCSI persistent reservation helper)
 - qemu-vmsr-helper (i386 only?)

all of these processes currently just accept a single listening socket,
and ignore the names.  They all abort if they are passed more than one
socket via systemd-style supervision.  With the exception of qga, they
all abort with an error if they are passed listener configuration
information while also being launched under systemd-style supervision
with a socket.

I don't see this narrow scope of functionality as being a difficult to
maintain for backward-compatibility.

We can simply offer a mechanism that these tools can use with the
semantics of "if only one socket-activated listener, claim it".

As far as i can tell, none of these four helper daemons is designed to
listen on more than one socket anyway.

          --dkg

PS in the course of thinking through this patch, one alternate approach
   did occur to me, but i'm not inclined to follow it as it might be too
   radical.  I thought i'd note it here anyway, in case anyone thinks
   it's interesting, or (alternately) wants to definitively close the
   door on it.

   The idea is that rather than just being able to pass a file
   descriptor by name anywhere that you can pass a file descriptor by
   number, qemu could use the name of the file descriptor to decide what
   to do with it.

   So, for example, rather than running:

      qemu -chardev socket,id=3Dfoo,opt=3D123,server=3Don ...

   the administrator could set up a systemd .socket file with:

      FileDescriptorName=3Did=3Dfoo,opt=3D123

   and have the corresponding systemd .service file would launch:

      ExecStart=3D/usr/bin/qemu ...

   One of the logistical challenges for that is that the colon (":")
   isn't permitted in FileDescriptorName, and some qemu options might
   want a colon in them.  And, this approach with -chardev doesn't
   necessarily translate well to all the various places that might also
   want a file descriptor (e.g. -incoming, -object, -spice, etc).

   So like i said, probably too radical, but i thought i'd mention it.

--=-=-=--

