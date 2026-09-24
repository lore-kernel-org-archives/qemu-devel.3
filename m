Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9DCC98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5X-0000ZI-Kb; Thu, 24 Sep 2026 03:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5U-0000XI-A4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5S-0001YP-RI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMyNCgLgFzmqrRn+pqyILweXoXHCn278X4Jc+1n7/9A=;
 b=I7icvYF8TTbuEzkM1iABk1Idl8/BLjBA4Wfio5A1AwKdNYVfg/tHlGKtz/my/9280c2kmC
 BWyYCHxkPP+M0jAESOCI/zFzDRDyfrd5Dzl4nvKqSE6xlEHZUN54U7RSV4aOsBJcRMXg7p
 mmCpVl3t4njxxSfKbS0ChE5+SskUhu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-7t1hi9quNJ6Mi3W6nGGzIA-1; Thu,
 24 Sep 2026 03:41:41 -0400
X-MC-Unique: 7t1hi9quNJ6Mi3W6nGGzIA-1
X-Mimecast-MFC-AGG-ID: 7t1hi9quNJ6Mi3W6nGGzIA_1790235701
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFB2C1800613; Thu, 24 Sep 2026 07:41:40 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3070E30001A2; Thu, 24 Sep 2026 07:41:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/10] tests: Add tests with commands with bad length
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-11-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-11-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566488.1794827.13839694120183851025.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=o7qtnY/QqhBd2r4kxvma75XIa3IsYjJgBzsYu+asQ6c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQTadACMJ718l/S2gfqbr4bAFMr3zZhC+d6p
 nNJ0fhKaVyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5fP5D/4kdZz4EbJvWh+iz+TRRlFSgvmoA/LuFclTeMHz2R4AV7HlLd23UXQuZDpyNil4YblT9fZ
 RNQueH7nU9dEuhU/illZ4TVXzQPFDoNBogWHz6gjcMeomFO/OK2TiEZvjV7IhFfFa1DRULlbbKG
 hEQkW17saR4FReT4+714+oU96zGu/mnJmcBxqwHbPxst7OsGp+cqDhC5pIP+18RcURB45bUIB9G
 qIbcLGagVjzvCEcrI5RkaZfZ0wP0WpqfCFi5ZVKDv9+GWcNoGoGKjGZr7UiejWfzyP2eVkIBRNu
 lpZEsLYdz2DIX8QxLpVsmlFTuPQkAHTDWTqzn89G5NPb86TzfcZHVTMcEOM9JIVLMZY6wHut8DW
 A4uQo90I9RFI2tsV6m8C2N/L7OIzXfcr8dlEykk/kkBpngT/CuOe6LZxz5wOZW+hSYDkJ+av7Al
 WbzIHXmHJcr7MOmibW6xIrxLJXSMXZjrVNBFwHtn4RlAD1CFnl+1qTY4UuHoDGTiHr1ba8aH0z8
 O//P+6nB3T6Vy0kVCKmgPsetZA4npe0Hd+gaoe4Q/tSwek/c0GDmcoHwNXPbtgPKTHwlGBILPru
 6bxbiTtxG8wSnBUne76kNPA1iHvJ7S2r9/N3xMLyWG3js0nWIdm0C7yqKDdxhaIsVIXOFQLFH1z
 GbggFcqUmYtZ4FA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 23 Sep 2026 21:25:27 -0400, Stefan Berger <stefanb@linux.ibm.com> wrote:
> Add two test cases with commands with bad length:
> 
> - Send a command that indicates a very large size (0x10000 bytes) to the
>   TPM. This will only work with the CRB interface since the TIS wants
>   to receive all the bytes indicated by the command header.
> 
> - Send a command that indicates that its size is only 9 bytes, which is
>   too short to be valid since the command header alone is 10 bytes.
>   This test only works with the TIS. The CRB silently rejects commands
>   that are shorter than the command header.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


