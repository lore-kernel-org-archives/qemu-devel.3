Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA80CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdTI-0002cP-LP; Mon, 11 May 2026 23:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMdTH-0002c1-1M
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:07:47 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMdTE-0007ZF-RR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:07:46 -0400
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50fbd79350dso47108971cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778555264; x=1779160064; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WxQtEpqi73DG/9KEsGNu1/q6QbGQO2MxaHaPEf6FI2I=;
 b=klOxJKGeevAK+wWPNMK1FgYAWVgzHvQQiskCjcYbLGVHVzVOrvTPJ6gXeZIKwcmHOJ
 6RgtmxB+YQ0McDNc5IfjEG0DObNc4Olfzfku0amKBK4IJ6wUcIkYWHfI+VG1SBtIl7m8
 TeaN9T3yFQVv3i1bFMSCBy/O/ICoAHV7WuBrI6CbskHh6gCe3gA2DUYYFglqhIrWeQR3
 YNStyAEWDymmiQET0OmIu06KIt1PP/7mYUD4wbLbg7lduQHcwhmqZQ62HNo2Izs7neVV
 /aGX10P+ZKPnRkpBsDsnC5ItAStDKZU1+zFj7rELkMm39tPwLDoy1Yxju4pAjS403FRu
 5FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778555264; x=1779160064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxQtEpqi73DG/9KEsGNu1/q6QbGQO2MxaHaPEf6FI2I=;
 b=huhglep7McpOokfmbRWJ+vhMiLuY51Uy4YrC1IBIB2K1gZeHCnxeTSIXYzlcewfI1g
 aUwtEF45TjVMPTYw4snKDiAbKg51uAl5peT2ZZgj0qUkZU1pfenyJoveG5sy/1Ah3mic
 VkvvQmUH7NPoPas/4cLMIDI6YSPLkC8JCerNi3PdrR+T/uoF9+zqSr2h9F/298Ji+KIB
 ymEJjv0y/47WLyb7apo7U0OVkzPbcLQzCYJCv7P1cjwRhqaJ5I7ARROuoluaW/gIE3HE
 SFvXSu1EQnF63ZQVDN+24Vm/KzsZossVqYKyJGRC/MGE9e/ueZxJ6pQJVqPkJjiJXBaQ
 n5Ag==
X-Gm-Message-State: AOJu0YzKVWAGLA/i1dEBB2JgODaDWV3cwovGGYu7A+AfRVCGT1rNvXA2
 f8vM4efuUT69blxHnxHhFoqxhoCizXLSXXBoor2ABIZ+sixKgd4Famxf
X-Gm-Gg: Acq92OFjuV+l2XrCQ6Bbqed4HjPy0TiD+e6ZQdE78ODbN8Xem/rVfk/J+RvGpPNHHAp
 9gxGwgKO9cAiLD/MhUI/GqpcwqCYZjh7l4FNsZpQ7MV5x0ijJBELITdbzOsaN18Gp9T9mLwkuFr
 P7xpbvjF4yhcTxIAPQ0YTBBLAykCeRFyN1xENJnoyqIhskULQM0xBcFbyoPns6H1n7s7GIgTHTY
 i4PUuzyY9qEu4vv/0olM4wSfSgZIpJuccPa5y3HLnbkWH6WIfmUNUKW7nGRqsiRXtZy3PIhwYDo
 G0IuCxZfmCypePTpaWbzAwhkoYx7cDPxAMjs2Vfgu7AHB3fnRQUmjLMe3EqTEQ0xjxbVPHb6qGi
 PXaD2zRH0lJedFifBfFK0F69lptcTVpQvdGKhzTzW2QvqIBXGicvstUMcRBvZGwHkaS3bxVbCZS
 dPPnBa0fWkXTgwcNockt/2ZRwwBsEJmnghVz3arbVqFXUv2/tl0RoybkhjA110S48yYxa+c1gE
X-Received: by 2002:a05:622a:130e:b0:4ff:c08a:52c4 with SMTP id
 d75a77b69052e-514a0a60df0mr189084301cf.18.1778555263399; 
 Mon, 11 May 2026 20:07:43 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e830ddfsm106489541cf.27.2026.05.11.20.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:07:43 -0700 (PDT)
Date: Tue, 12 May 2026 11:07:30 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 07/10] .agents/skills: add qemu-mail-thread skill
Message-ID: <agKYkWa_SUp0Zo0F@ZEVORN-PC.localdomain>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-8-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x844.google.com
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

Hi Alex,
On Mon, May 11, 2026 at 06:04:56PM +0100, Alex Bennée wrote:
> Teach agents how to fetch and deal with archives of mail threads.
> 
> Just YOLO'ing the entire mail thread into an LLM context is quite
> expensive especially if reviewing a thread against your current tree
> state. This skill allows the agent to extract just the comments and
> tags saving tokens.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - rename to qemu-mail-thread
>   - add instructions on fetching threads via b4
>   - refactor the metadata handling in the script
>   - mention in AGENTS skill list
> ---
>  .agents/skills/qemu-mail-thread/SKILL.md      | 34 +++++++
>  .../scripts/qemu_mail_parser.py               | 98 +++++++++++++++++++
>  AGENTS.md                                     |  1 +
>  3 files changed, 133 insertions(+)
>  create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
>  create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
> 
> diff --git a/.agents/skills/qemu-mail-thread/SKILL.md b/.agents/skills/qemu-mail-thread/SKILL.md
> new file mode 100644
> index 00000000000..58e7c833a27
> --- /dev/null
> +++ b/.agents/skills/qemu-mail-thread/SKILL.md
> @@ -0,0 +1,34 @@
> +# QEMU Mail Thread
> +
> +This skill helps you fetch and extract reviewer comments from QEMU mailing list threads. It can handle standard `mbox` files (e.g., from `b4 mbox`) or raw text dumps from the user.
> +
OpenAI Codex (v0.129.0-alpha.2) shows a warning when loading this skill:

⚠ Skipped loading 1 skill(s) due to invalid SKILL.md files.

⚠ /home/zevorn/qemu/.agents/skills/qemu-mail-thread/SKILL.md: missing YAML frontmatter delimited by ---

I suggest adding a check-skill script that validates skill format.

Thanks,
Chao
> +## How to fetch a mail thread
> +
> +If you have a Message-ID (e.g., from a patch series), use `b4` to fetch the entire thread:
> +
> +```bash
> +b4 mbox <message-id>
> +```
> +
> +This will typically save an `.mbx` file in your current directory.
> +
> +## How to parse comments
> +
> +Use the included Python script to extract feedback, filtering out quoted text and diffs.
> +
> +```bash
> +python .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py <path_to_mail_thread_file>
> +```
> +
> +The script automatically detects whether the input is a standard mbox or a raw text dump.
> +
> +## Expected Output
> +The script generates `parsed_comments.txt` in the current working directory:
> +```
> +--- REPLY FROM Reviewer Name <email@example.com> ---
> +Subject: Re: [PATCH 01/10] ...
> +Comment text here...
> +============================================================
> +```
> +
> +Use this structured text to efficiently analyze the feedback and identify outstanding suggestions.
> diff --git a/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
> new file mode 100644
> index 00000000000..fdaac57ac15
> --- /dev/null
> +++ b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +import sys
> +import os
> +import mailbox
> +
> +
> +def is_metadata_line(line):
> +    """Check if a line is metadata (quotes, diff, etc.)"""
> +    return (line.startswith(">") or
> +            line.startswith("---") or
> +            line.startswith("diff "))
> +
> +
> +def parse_raw_text(text, output_f):
> +    # Split by the separator used in lore.kernel.org / b4 dumps
> +    messages = text.split("----------------------------------------")
> +    for msg in messages:
> +        if not msg.strip(): continue
> +
> +        lines = msg.strip().split('\n')
> +        author = ""
> +        subject = ""
> +        body_start = 0
> +        for i, line in enumerate(lines):
> +            if line.startswith("From: "): author = line[6:]
> +            if line.startswith("Subject: "): subject = line[9:]
> +            if not line.strip() and body_start == 0:
> +                body_start = i + 1
> +                break
> +
> +        is_reply = subject and ("Re: " in subject or subject.startswith("Re:"))
> +
> +        if is_reply and author != "" and not author.startswith("qemu-devel"):
> +            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
> +
> +            for line in lines[body_start:]:
> +                if not is_metadata_line(line):
> +                    output_f.write(line + "\n")
> +            output_f.write("="*60 + "\n\n")
> +
> +
> +def parse_mbox(mbox_path, output_f):
> +    mbox = mailbox.mbox(mbox_path)
> +    for message in mbox:
> +        subject = message['subject']
> +        if subject and 'Re: ' in subject:
> +            author = message['from']
> +            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
> +
> +            payload = message.get_payload()
> +            body = ""
> +            if isinstance(payload, list):
> +                # Handle multipart
> +                for part in payload:
> +                    if part.get_content_type() == 'text/plain':
> +                        body = part.get_payload(decode=True).decode('utf-8', errors='ignore')
> +                        break
> +            else:
> +                body = message.get_payload(decode=True).decode('utf-8', errors='ignore')
> +
> +            # Simple heuristic to extract comments
> +            for line in body.split('\n'):
> +                if line.strip() and not is_metadata_line(line.strip()):
> +                    output_f.write(line + "\n")
> +            output_f.write("="*60 + "\n\n")
> +
> +
> +def main():
> +    if len(sys.argv) < 2:
> +        print("Usage: python qemu_mail_parser.py <mail_thread_file>")
> +        sys.exit(1)
> +
> +    input_file = sys.argv[1]
> +    output_file = "parsed_comments.txt"
> +
> +    if not os.path.exists(input_file):
> +        print(f"Error: File not found - {input_file}")
> +        sys.exit(1)
> +
> +    with open(output_file, "w", encoding="utf-8") as out_f:
> +        # Detect if it's an mbox or raw text
> +        with open(input_file, 'rb') as f:
> +            header = f.read(15)
> +            is_mbox = header.startswith(b'From mboxrd@z ')
> +
> +        if is_mbox:
> +            print(f"Parsing {input_file} as mbox...")
> +            parse_mbox(input_file, out_f)
> +        else:
> +            print(f"Parsing {input_file} as raw text dump...")
> +            with open(input_file, "r", encoding="utf-8", errors='ignore') as f:
> +                text = f.read()
> +            parse_raw_text(text, out_f)
> +
> +    print(f"Done. Extracted comments saved to {output_file}")
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/AGENTS.md b/AGENTS.md
> index fbbc3b65ed0..d99d3078378 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -28,6 +28,7 @@ You should use the following specialized skills for common tasks:
>  - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
>  - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
>  - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
> +- `qemu-mail-thread`: For analyzing and parsing mailing list threads.
>  
>  ## Source Code Layout (see `docs/devel/codebase.rst`)
>  - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
> -- 
> 2.47.3
> 
> 

