Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F935F327BF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF6Cs-0001QN-W5; Tue, 21 Apr 2026 04:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wF6Cr-0001Q0-GN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:11:41 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wF6Cp-0002qe-Sp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:11:41 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-12c7212836bso10368378c88.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776759098; cv=none;
 d=google.com; s=arc-20240605;
 b=PQqLnPEhDTZSsXN4MH/wBdxiB1O/qf9EQtSgPY1o90P5QX+OMBhmn3aeKg7MFE9MY1
 6YRcLAlHvmOWsio+eIb+g8xCjgbG5yZxgpQtv5TpL0lpNDdMm7M6coLSGhKr2XUzvIhp
 duxzOm2EtxJOjJ0ZNFY32FJBFny+M+duAfSpdNS0zw1bXmghPq17X4Pzsf550nFvkwYD
 AsEVhA+QyGhfTX4aedzV0gXg96P3GrXdVpPbMtPOqFIOYfo2GiA/HkT5JvbAK8vZsfq9
 mMK7jrjZvueKz1Pse3hJ8tOy56TCyYTemWqarAcBvjco5MgzrSkaf7GA9gjU1OEoJSFG
 R/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=tBq+YF965P03PDw5Zq6dZTnxqK8UcLjJakGrEQXw2YE=;
 fh=f5E/eXbABplc4UmKfkwN8PaFFZEYUlpwsNE0wcaG5p0=;
 b=JUwFr0xD7AQFCZk4iREcU4osXN0nLHIDQtR4ljKlRY6j6pdQpo6ZwKI8nKKT3Y+ejD
 tyEP6u+6CtZbNwn4ZH3rR9ek61Hlg+JFJeOsKWSLKNMkfxmCs5ZOxjWqjmMcM3rqRa7P
 lb4RdCf0+HpZz1SI40l7XxjRfCJ1AZubMFpgpoMwHOhFOl/MWq5dESHEWGwY9rpHmYG/
 nZtLNjgGbDP8lwjF+VkvZJs8ByM/Hg/ZevNQAd2t26vD/y+9zdTAFAwXyfxXRVVAu1f+
 ym6K6yqxhL26JqFsiLY/dS4+jxXl5vd8mbbbHW9TrK2IJj/zAT4eeDZGOxxDRpHzrt6T
 eeaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776759098; x=1777363898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBq+YF965P03PDw5Zq6dZTnxqK8UcLjJakGrEQXw2YE=;
 b=QtLfU41X4bSzCz55MD/+cCc6f2Y8ovifDxbZWZKfvI5BAo7Ng8ViwCiarPCU6fIkgu
 aKpTXAW4G6+QpLPRtoXDBBUyyzA/ffrKpNFgxaJE52m3L4GKv4uNUzcuIvAv+P6WvnqE
 W47//cG69QntSbIabjPj1vV1iCkJQCpYE9OkK8Fv4q8TmhKhUna6mi2pimHPppt5kz7F
 dir6BHwgpkyaXlK2cg4JFrG9mF+TyMpOeRQ6Ex2UNIAX03Rn5fRcjamEJMFxvTpERGSj
 OuH6dd/T9yQajY1G7/2p9fRDrBhujYPpzz2opm/y6s05J1kh/aZ2jJe2CoF6T6qoUR/Q
 Sm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776759098; x=1777363898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBq+YF965P03PDw5Zq6dZTnxqK8UcLjJakGrEQXw2YE=;
 b=F+wkpi3OllJwhSf58ziUPxdsgGgwHv26LC7GF37Onsf3PaDm5r2zwJlZ/w+vZa59RN
 6F1Z0J7YafHZIgfhKG/uzJ2DPS4Iwp/FRS/758AW0PUI9atohJ6mWKtuhUoMUMlqVb9Q
 SlI4bRW6UB0yzE2sZGNYmS7Y3vXZBs6MIn9msYl93g+m4GxwsFXZRT0vSLwPwS0wlGE2
 7mCji+8UZGqHVBrz7wCykO5dvBt5zeKTw3oMoH7XNOrKG1sRKV3zAplubOKIL1mc0jWx
 YxUH8+hG4T+F+h0WjBd3zsijODHGCAHn9pqn3D1ygTCQSz4P0KvvXEThk02RhnkTFkmp
 7o/A==
X-Gm-Message-State: AOJu0YwNqI/zjCS916ld+MIC6ZZ17NQ2KK4aEjFA1k5ckswpgt3FDq6v
 jSRtMYGnh9KwdhZUr9mLlEmAc6KviPhM9dbS667c7yTVtiUHNnA5N4WfVJ+XIhxveA1/1QBD5o0
 WtTxctjUOlwPfwqD/i/M/UkzESWE6xiKvCI29
X-Gm-Gg: AeBDies0wqsBnaxJwOK6cnl4RXJZ5BvgBKypxTLz4eFD2xvfpaFHDI82uYh8pzq7y+b
 AV7NJlhmKbMw6qsmSyDz885WCBDnXHjT98LkAQuWuXPssyksB0z5amp3AYMccYlOhlvFOlGHCV1
 KEHSjhJLl7Zk8Ggb+yc0nrs5Xr6RJ7N5lam9szlDWNdrZao0QXtS1v+pRjRWutwSmPRzuWvVPOJ
 bO+9BWddKmcBjf8tN/hPzoR9dVNJF9EdCdkpYKJXyRcHoVzkCO0+uqixcrQSArWytEpXQJ31Yev
 XrHwdGtApXJNKBzy7cKZpqiCVTt42E8/3v4TKEIMlSAZ8R/q4yU=
X-Received: by 2002:a05:7300:148c:b0:2c7:287:6740 with SMTP id
 5a478bee46e88-2e47930948emr10423162eec.28.1776759097649; Tue, 21 Apr 2026
 01:11:37 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Apr 2026 12:11:26 +0400
X-Gm-Features: AQROBzCwsrKQDdTLSofVXO5pQrY5_EtCbLEue2c4--p5ROhYrA1BmAsSMmd6dcQ
Message-ID: <CAJ+F1C+ukA5ZBDLaeTmjwKXdiOdG6Ob11+nUG0Ct_SpAaUx+Mw@mail.gmail.com>
Subject: About query-qmp-schema
To: QEMU <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

The query-qmp-schema returns a stripped-down version, removing types
unused by commands and events. It also renames types with integers.

That makes it impractical for a client to know which values are
acceptable for a generic qom-set commands: qom-list returns the real
"unmasked" type name, and it may be a type that is not even used by
qmp commands/events. A quick test shows the current schema is about
~243kb of json. With all types, it grows to ~273kb. Unmask it grows to
~308kb.

Could we send the full version? Eventually, we could have a "flavour":
"full" argument.

Another option is to compress the schema. A "full-gz" in baes64 would be 51=
kb.

--=20
Marc-Andr=C3=A9 Lureau

