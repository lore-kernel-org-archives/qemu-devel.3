Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F713EA794D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnm62-0007yy-Lb; Wed, 04 Feb 2026 18:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkWV-00011s-6J
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:34:55 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkWT-0002S0-D6
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:34:54 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-126ea4e9694so550970c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770240891; cv=none;
 d=google.com; s=arc-20240605;
 b=FJx7KiH1tV+k5JaeNpYcgKuYhJnlOZ02KT8jqNf6CKqbqDgJerIphEMwR738QSSNsK
 wMqkVIoQDPh9R9kFZGX/fug8zyN1xS9LI6eu5CLIHmtvUp9KXXyYr9xH4R/L9jYL+QLv
 2q26nkHeNkfGN3nj/xQjsd3UqrCCyJlP9UsoPNzTqmSR/tz3BaMRBi1ZO4lmo6jvaCTN
 QeyNQINqHe8HUK9FDUML+/x7KwZ28hirwH4639FEoGj8rrIJNWXvZSt1sYtCUN9rI9ak
 wA01sGLLNQk4i1+3lbDJG7uQCqycDdi41j08B4J7PFI+L2ga1q+Mn2CnSXqTm7PKdG7g
 Vj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
 fh=NLPM9XS17x1fVW1Kxo9RZ+Hy5yhAI67fBi6K4q/Fxno=;
 b=VdQ7hVkkKTXTMAt3QaLdbn+2qIzQdTdvRdW+8K0fZUas3++0s+j9ZBYHGQRAxXTg63
 u9V5DKliDEnMmZzoM2JvwyEF93NKM7XmemARIJJhvFdshHHUtuxmMfVvBZOb6NHqOyVh
 iBO4MI7CCAnqJokvBvSr7VXb3ntnZ7gbFtDkGdVJDXT1RuxQVK2FpeAo7JhBFIk4kWw7
 tY8HcvXaxQpigHuy+cxlHARdnIjLT+BZVUHV0drT6HZyZnbck0XUqYbiet16MGnlvQ7d
 SR1dKOs3X1Dh92BTnjLdz+jveo80vlI4HDMy2cWnRMw7WXnyPCmIFoqKJn+ZY7NiGfO1
 a9rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770240891; x=1770845691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
 b=Z8A+ZA88poP59gRo0L+iDOAa7p2RwyMIXXZWmvfFhEj+Wv9K8YPyRjaAgXFcG1Hnqs
 RksxxlxRzalGQ6UfacZSPVxO1A9nydN9MNY5i3X3IJVNhD8K79iZ0NNCbIBGbu09oTen
 9tsk5Y1wKO4/WLC1LVtA62FmtBACa31wkYE+iQe6ErtX773a4mBHT5YWn/23MUH89eN0
 q/j60kSpQr4b/xflBfFDebSbJZqdt6ir5/kroWZdRFqyjQGRBbd4svxlz87Xs1RBXuUH
 712JvgxeDM0YspuoXm8A9w0ONLCDfbKgpxAu7fWRg6eHu6EkkPC8IDWtTrsWuqE0xf7D
 UIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240891; x=1770845691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
 b=R6HD4q3Ij1Gw82pZoZYCnw3lk2P20gi3aPKwLR2uU2YRLiSB5mQSi2SthAHQz115xQ
 OCFAnuBJXevtwL1uNmjRiL23hGf0RrnXw2A5SGq5jMZ4U8cZSs2xsrKW+pCojI+9lmPM
 c/p49fRv56YPXdx9gvHu03n7Tf3ayk7GlXDC6c2dVUs67yjQe63moLFUAHGJqsNeKukp
 DH7sa4sMP1WJK+EbETOrQuKIILt9uWOX2k1BrzYw6L8GTYaWO/8afWFadBx9WxbJB000
 vjq0BLHxRcW6+LwafSlX9iy2cY/TzSkiE7fpt3yMM0PcJ6qUOBiNEXjVhv/qHO2CKNyt
 lClQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQDE23U8diGUzAIE7l6dOD+F4N2EKFZlvHiKkoW0NhbSg0+LVdA2lGND4kkSsQYruENE9aZFSuhjb@nongnu.org
X-Gm-Message-State: AOJu0YyVXjavhdhhDlfi0Ag27FBNmMlLqPZ5DLWXzkwch1YjvOU+YNKq
 YZsUVoC4DoX08LNuaIhC2v83jVTO3KVuWPSytuUfBeJcO0y8aR+f3z/UwmuYuMZoyQlYWN+Jva5
 nHANwS6PT/lm07TAmO0OHMMztgpZrAQ==
X-Gm-Gg: AZuq6aI8Ba6nDSFqzbkszPpZ3D06PrTUbjm4lbIPDg61avq52gHdtkCwf3LWqqJVlKq
 gc6tWJl168OEFX+Gt5oSzIQelJa1vi5e15ktzWx92QvUwYFlKHYy1ZMnIvjQYKiAlRaYsU4JeOa
 n7oVKHDXdkdGwH1etRXvgQxgzY5Vwdr8kaf1O7Lkpnfv5eDWF3Eftm1h6dZJempVD275Oj2CW5J
 g0KbCmzLl2SarsTcUA1ij/K5a+t/QjxU+dsj/Z588mJuhhSGU85mVDIpHUvCa7ezNP+Gh2d0PO5
 /7KbBQ==
X-Received: by 2002:a05:7022:6182:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-126f47cf682mr2223956c88.40.1770240891041; Wed, 04 Feb 2026
 13:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-2-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:34:39 -0800
X-Gm-Features: AZwV_QhWmPRYqkKRihjkWxw9e2dGMntWfyDbx2dd1u5SPwdzPVuRXZJ0L1T4Wk0
Message-ID: <CALa+Y14TRzSx3hJ0rLOH2dWC3kvKVOFws4VpQmKmJ-gWw_6ECg@mail.gmail.com>
Subject: Re: [PATCH qemu v4 1/5] qapi: cxl: Refactor CXL event injection for
 common commands arguments
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 shiju.jose@huawei.com, 
 armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
 Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=ravis.opensrc@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 18:15:41 -0500
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

On Mon, Jan 19, 2026 at 3:21=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Refactor CXL event injection to use struct for common command
> arguments.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v3: Fix wrong comment for memory module event (Markus)
> ---
>  qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index eeddb58d1d3f..55a088586e53 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -31,11 +31,10 @@
>   }
>
>  ##
> -# @cxl-inject-general-media-event:
> +# @CXLCommonEventBase:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> -# specified via the log parameter.
> +# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> +# Table 8-42 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
> @@ -44,6 +43,16 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# Since: 8.1
> +##
> +{ 'struct': 'CXLCommonEventBase',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +
> +##
> +# @CXLGeneralMediaEvent:
> +#
> +# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,26 +83,29 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLGeneralMediaEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>
>  ##
> -# @cxl-inject-dram-event:
> -#
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> -# This event type is reported via one of the event logs specified via
> -# the log parameter.
> +# @cxl-inject-general-media-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# logs specified via the log parameter.
>  #
> -# @log: Event log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': 'CXLGeneralMediaEvent' }
> +
> +##
> +# @CXLDRAMEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> @@ -133,9 +145,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLDRAMEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint=
32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> @@ -143,18 +155,21 @@
>             }}
>
>  ##
> -# @cxl-inject-memory-module-event:
> -#
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> -# at the time of the event.
> +# @cxl-inject-dram-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.
>  #
> -# @log: Event Log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': 'CXLDRAMEvent' }
> +
> +##
> +# @CXLMemModuleEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
>  #
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
> @@ -185,9 +200,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> -            'type': 'uint8', 'health-status': 'uint8',
> +{ 'struct': 'CXLMemModuleEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
> @@ -195,6 +210,18 @@
>              'corrected-persistent-error-count': 'uint32'
>              }}
>
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0
> +# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> +# at the time of the event.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': 'CXLMemModuleEvent' }
> +
>  ##
>  # @cxl-inject-poison:
>  #
> --
> 2.48.1
>
>
No comments.

Reviewed-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

