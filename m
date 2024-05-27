Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B6C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVGu-0004ne-8m; Mon, 27 May 2024 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGA-0004WZ-K1
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:11 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVG6-0004Vj-3Y
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796746; x=1748332746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wfJxUoWkAKz49qPIzWTxNIlg6L1CdTDJUI+5LNs+U+s=;
 b=ZNp2HFJnnOBdAmMyUQT590Ql0tv7oWV+gSzyfzQ4FqPV9qsKcgc3wvKO
 K3wXa+8xU6sQZvqO/XBiBVilb2dWPtz/kKn+66ftPY+qyqR+L5jFKopvF
 d9fogEB0qyPP5sfHXZJ2z4PZ0gfN0yxhdopCwuKgdQEPwnvANdK9MlmJf
 FZHztohcuv5p3cmu8jqrFUHhoPJu95gbx+IL0r5AqMF284fK9cuCb9uEG
 HDUbBaRs/PAFgj0sdm9H+EZhroL9Pk9zei8OKrP/AhsiInXRNNvSTRRdX
 Ki7BMJ6Z6aNIhAlno0KifIN/xUPeu9z8B2z9+9JNyUXWlIyMctDSg7pTo Q==;
X-CSE-ConnectionGUID: PrBRXvapRsWTERKNn582qQ==
X-CSE-MsgGUID: 2D1AbdLvT9ehGIJW1zsquQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967703"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:02 -0700
X-CSE-ConnectionGUID: jzYWghKVSCiEzZVLet1PiA==
X-CSE-MsgGUID: PQ8rg6iwSu+A698NJ4cdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39084935"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:58:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Date: Mon, 27 May 2024 16:14:15 +0800
Message-Id: <20240527081421.2258624-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi maintainers and list,

This RFC series attempts to re-implement simpletrace.py with Rust, which
is the 1st task of Paolo's GSoC 2024 proposal.

There are two motivations for this work:
1. This is an open chance to discuss how to integrate Rust into QEMU.
2. Rust delivers faster parsing.


Introduction
============

Code framework
--------------

I choose "cargo" to organize the code, because the current
implementation depends on external crates (Rust's library), such as
"backtrace" for getting frameinfo, "clap" for parsing the cli, "rex" for
regular matching, and so on. (Meson's support for external crates is
still incomplete. [2])

The simpletrace-rust created in this series is not yet integrated into
the QEMU compilation chain, so it can only be compiled independently, e.g.
under ./scripts/simpletrace/, compile it be:

    cargo build --release

The code tree for the entire simpletrace-rust is as follows:

$ script/simpletrace-rust .
.
├── Cargo.toml
└── src
    └── main.rs   // The simpletrace logic (similar to simpletrace.py).
    └── trace.rs  // The Argument and Event abstraction (refer to
                  // tracetool/__init__.py).

My question about meson v.s. cargo, I put it at the end of the cover
letter (the section "Opens on Rust Support").

The following two sections are lessons I've learned from this Rust
practice.


Performance
-----------

I did the performance comparison using the rust-simpletrace prototype with
the python one:

* On the i7-10700 CPU @ 2.90GHz machine, parsing and outputting a 35M
trace binary file for 10 times on each item:

                      AVE (ms)       Rust v.s. Python
Rust   (stdout)       12687.16            114.46%
Python (stdout)       14521.85

Rust   (file)          1422.44            264.99%
Python (file)          3769.37

- The "stdout" lines represent output to the screen.
- The "file" lines represent output to a file (via "> file").

This Rust version contains some optimizations (including print, regular
matching, etc.), but there should be plenty of room for optimization.

The current performance bottleneck is the reading binary trace file,
since I am parsing headers and event payloads one after the other, so
that the IO read overhead accounts for 33%, which can be further
optimized in the future.


Security
--------

This is an example.

Rust is very strict about type-checking, and it found timestamp reversal
issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
deeper with more time)...in this RFC, I workingaround it by allowing
negative values. And the python version, just silently covered this
issue up.


Opens on Rust Support
=====================

Meson v.s. Cargo
----------------

The first question is whether all Rust code (including under scripts)
must be integrated into meson?

If so, because of [2] then I have to discard the external crates and
build some more Rust wheels of my own to replace the previous external
crates.

For the main part of the QEMU code, I think the answer must be Yes, but
for the tools in the scripts directory, would it be possible to allow
the use of cargo to build small tools/program for flexibility and
migrate to meson later (as meson's support for rust becomes more
mature)?


External crates
---------------

This is an additional question that naturally follows from the above
question, do we have requirements for Rust's external crate? Is only std
allowed?

Welcome your feedback!


[1]: https://wiki.qemu.org/Google_Summer_of_Code_2024
[2]: https://github.com/mesonbuild/meson/issues/2173
[3]: https://lore.kernel.org/qemu-devel/20240509134712.GA515599@fedora.redhat.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (6):
  scripts/simpletrace-rust: Add the basic cargo framework
  scripts/simpletrace-rust: Support Event & Arguments in trace module
  scripts/simpletrace-rust: Add helpers to parse trace file
  scripts/simpletrace-rust: Parse and check trace recode file
  scripts/simpletrace-rust: Format simple trace output
  docs/tracing: Add simpletrace-rust section

 docs/devel/tracing.rst                 |  35 ++
 scripts/simpletrace-rust/.gitignore    |   1 +
 scripts/simpletrace-rust/.rustfmt.toml |   9 +
 scripts/simpletrace-rust/Cargo.lock    | 370 +++++++++++++++
 scripts/simpletrace-rust/Cargo.toml    |  17 +
 scripts/simpletrace-rust/src/main.rs   | 633 +++++++++++++++++++++++++
 scripts/simpletrace-rust/src/trace.rs  | 339 +++++++++++++
 7 files changed, 1404 insertions(+)
 create mode 100644 scripts/simpletrace-rust/.gitignore
 create mode 100644 scripts/simpletrace-rust/.rustfmt.toml
 create mode 100644 scripts/simpletrace-rust/Cargo.lock
 create mode 100644 scripts/simpletrace-rust/Cargo.toml
 create mode 100644 scripts/simpletrace-rust/src/main.rs
 create mode 100644 scripts/simpletrace-rust/src/trace.rs

-- 
2.34.1


