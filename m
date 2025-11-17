Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A33DCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxuo-0001Dy-2F; Mon, 17 Nov 2025 07:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vKxue-0001Aa-Q3; Mon, 17 Nov 2025 07:00:53 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vKxuc-0007Q3-FG; Mon, 17 Nov 2025 07:00:52 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 18CB480777;
 Mon, 17 Nov 2025 13:00:39 +0100 (CET)
Message-ID: <78b26e48-15a9-424b-a2d5-6ec900661c68@proxmox.com>
Date: Mon, 17 Nov 2025 13:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vdagent: fix windows agent regression
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: lucas.kornicki@nutanix.com, qemu-stable@nongnu.org
References: <20251027130744.2714610-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20251027130744.2714610-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1763380809353
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Am 27.10.25 um 2:09 PM schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since commit f626116f ("ui/vdagent: factor out clipboard peer
> registration"), the QEMU clipboard serial is reset whenever the vdagent
> chardev receives the guest caps. This triggers a CHR_EVENT_CLOSED which
> is handled by virtio_serial_close() to notify the guest.
> 
> The "reconnection logic" is there to reset the agent when a
> client (dbus, spice etc) reconnects, or the agent is restarted.
> It is required to sync the clipboard serials and to prevent races or
> loops due to clipboard managers on both ends (but this is not
> implemented by windows vdagent).
> 
> The Unix agent has been reconnecting without resending caps, thus
> working with this approach.
> 
> However, the Windows agent does not seem to have a way to handle
> VIRTIO_CONSOLE_PORT_OPEN=0 event and do not receive further data...
> 
> Let's not trigger this disconnection/reset logic if the agent does not
> support VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL.
> 
> Fixes: f626116f ("ui/vdagent: factor out clipboard peer registration")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reported-by: Lucas Kornicki <lucas.kornicki@nutanix.com>

Thank you for the fix!

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

and with my very limited knowledge in the area:

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>

CC: qemu-stable, because it affects 10.1


