Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81661C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bV-0001f9-KL; Wed, 12 Aug 2026 10:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bT-0001ax-Sx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bS-0003Dc-Am
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNnLoAI0ZK2J6mhU1/jMjhDZU/r+faYFiItu5PoeeLg=;
 b=GvjYyah5a+ywlHj6qPLE2hfDhBGapeQ6zxM3KEyiZFN+ijSgDkTA5GUiOTeQ5Y8/6F8vZG
 q0NWA6CycXsV/SoiWS+em3joyJWKIt6eGRRxAw7lmQAboPoAN1/9q3cr6SfTeBXh51fjxD
 4eIUQq/5MbhScKD9E+aXkvT+56A9bKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-omqZW3VtPfiG0GYIvDsAmQ-1; Wed,
 12 Aug 2026 10:06:42 -0400
X-MC-Unique: omqZW3VtPfiG0GYIvDsAmQ-1
X-Mimecast-MFC-AGG-ID: omqZW3VtPfiG0GYIvDsAmQ_1786543601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 337091800471; Wed, 12 Aug 2026 14:06:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52182195DF98; Wed, 12 Aug 2026 14:06:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 15/16] system: Extract QMP memsave/pmemsave commands
 to physmem-qmp-cmds.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260812131147.83188-16-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-16-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354344.2071945.4799928241931369079.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=564;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nRZygZQNK06uwSXfTlNClHXaKprcGg4kh0i807Odqc8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH27jaHJUOp+40fD1g8HnaBd9N5/ZJdjUHcxq
 X34X+XJW1iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9uwAKCRDa6OEJdZac
 5SkxEACGGkUZTKrVE2azwf2C8OwmbDog6B7OovsXcQd2A+ZL7YvwrzL9buMRQMz5+bu5EMqEEi4
 YYV6ETIUIDyf9JShI+Xw4AOjCaNObeTZ/8uEnXZQwviIBm1jvGVX9UjjNEZsDZk4du1EHJnoRkN
 qGYDRPkppe44XpUXEAOZwnZBkXcy941QJYj170oSaRKSnA2vDY91YhwvLzVOVkzH/+AQTFsQzHs
 yDCgRJQ2ynvCpNHwNiPWpi4ax2s3ehA0PsCOOCDKFWp1VZ/5nE5EOuefEXnvN6/1fjY/e0i3c2e
 wZlkXX4lmSXuG4aOXD3yYxVjbrOjRpqoarZK3Zp0K/1eDiUlr6kuIJH3Au2NwyqQ2H0li3f9Ay/
 qRS6hrysy5HKcKHFXyF0A1coOYD+935uDUw3Lxtyb316OZRAEc5XyJ0v4Ws51HE0zBZT+YQDa6E
 5nsk7X/FOJWuqcc7aw0Ux3ss6sO3R7CUi2nUAB+TIlurc+XYLeIg7WmzE6/HsXYhPzf3/wM8QM2
 pwvwTj5LLrISIr+nGGezNSL3/O7m5LwpESIDeSCZKbeyEzCHkb2Qj2AuvKXCrHMwddYk2PeOCH1
 2CW1PJDldvJSh3PYJATP5oZFDQpqJStCnqUmacrBNi1I4DlJJVufh2OJijjNn3t3PoHX0kWo+gc
 fl891ol7rDbcbrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:46 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Keep cpus.c related to vCPU scheduling, move the QMP handlers
> related to dumping physical memory to file to their own unit.
> Fix a pair of checkpatch.pl errors doing so:
> 
>   ERROR: braces {} are necessary for all arms of this statement
>   #185: FILE: system/physmem-qmp-cmds.c:51:
>   +        if (l > size)
>   [...]
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


